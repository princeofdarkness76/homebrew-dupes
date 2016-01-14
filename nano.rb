class Nano < Formula
  desc "Free (GNU) replacement for the Pico text editor"
  homepage "http://www.nano-editor.org/"
  url "http://www.nano-editor.org/dist/v2.5/nano-2.5.0.tar.gz"
  sha256 "ff323e6fef74caf0a924304841c07ac65ec30db99dc5c1f8272b4c536a5c89ee"

  bottle do
    cellar :any
    sha256 "35b4a4014ab36ccfa89aa38c74ae8179c26de5d786d08fee33a852ab397ad0b9" => :el_capitan
    sha256 "f42d3c2164c916f2ae0596bd30b64251568b710e79b7260e80a655abbef66f51" => :yosemite
    sha256 "e21a36b319b7a8abdc5f3a082f681d773ad1c8337b94805636c542594ae07798" => :mavericks
  end

  head do
    url "svn://svn.sv.gnu.org/nano/trunk/nano"
    depends_on "automake" => :build
    depends_on "autoconf" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "gettext"
  depends_on "homebrew/dupes/ncurses"

  def install
    # Otherwise SIGWINCH will not be defined
    ENV.append_to_cflags "-U_XOPEN_SOURCE" if MacOS.version < :leopard

    system "./autogen.sh" if build.head?
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--sysconfdir=#{etc}",
                          "--enable-color",
                          "--enable-extra",
                          "--enable-multibuffer",
                          "--enable-nanorc",
                          "--disable-nls",
                          "--enable-utf8"
    system "make", "install"
  end

  test do
    system "#{bin}/nano", "--version"
  end
end

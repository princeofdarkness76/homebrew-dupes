class Screen < Formula
  desc "Terminal multiplexer with VT100/ANSI terminal emulation"
  homepage "https://www.gnu.org/software/screen"

  stable do
    url "http://ftpmirror.gnu.org/screen/screen-4.3.1.tar.gz"
    mirror "https://ftp.gnu.org/gnu/screen/screen-4.3.1.tar.gz"
    sha256 "fa4049f8aee283de62e283d427f2cfd35d6c369b40f7f45f947dbfd915699d63"

    # This patch is to disable the error message
    # "/var/run/utmp: No such file or directory" on launch
    patch :p2 do
      url "https://gist.githubusercontent.com/yujinakayama/4608863/raw/75669072f227b82777df25f99ffd9657bd113847/gistfile1.diff"
      sha256 "9c53320cbe3a24c8fb5d77cf701c47918b3fabe8d6f339a00cfdb59e11af0ad5"
    end
  end

  bottle do
    sha256 "2589ee93c83a8ecdb6823b31ed94a14e1eba0932cf73d33a9c1941cf25919fc9" => :el_capitan
    sha256 "4a46700acd2fa5c174f21bf2631122815b122727b22e04927d70049f14a77bcc" => :yosemite
    sha256 "4c91084adb0ec83e263f0038b812742c293c1b910d4c9ea4e9b8cb6fdce3d66c" => :mavericks
  end

  head do
    url "git://git.savannah.gnu.org/screen.git"

    # This patch is to disable the error message
    # "/var/run/utmp: No such file or directory" on launch
    patch do
      url "https://gist.githubusercontent.com/yujinakayama/4608863/raw/75669072f227b82777df25f99ffd9657bd113847/gistfile1.diff"
      sha256 "9c53320cbe3a24c8fb5d77cf701c47918b3fabe8d6f339a00cfdb59e11af0ad5"
    end
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  def install
    if build.head?
      cd "src"
    end

    # With parallel build, it fails
    # because of trying to compile files which depend osdef.h
    # before osdef.sh script generates it.
    ENV.deparallelize

    system "./autogen.sh"
    system "./configure", "--prefix=#{prefix}",
                          "--mandir=#{man}",
                          "--infodir=#{info}",
                          "--enable-colors256"
    system "make"
    system "make", "install"
  end

  test do
    shell_output("#{bin}/screen -h", 1)
  end
end

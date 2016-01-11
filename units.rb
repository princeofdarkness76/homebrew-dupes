class Units < Formula
  desc "Utility to convert between different systems of units"
  homepage "https://www.gnu.org/software/units/"
  url "http://ftpmirror.gnu.org/units/units-2.01.tar.gz"
  mirror "https://ftp.gnu.org/gnu/units/units-2.01.tar.gz"
  sha256 "138b12c70bffa0e484fdfe579927412b1ac573e8351c17d8938592f9ba9a88f2"

  bottle do
    sha256 "895f1cd13ff45a9dd1756a44a4159b550480ddff895a13f9336b316752d0d7ac" => :el_capitan
    sha256 "643f93a9a83081a28932b8ffad744db0bdf61723ada1bb7686f9dee2af26aa41" => :yosemite
    sha256 "3897bdd0c6a5ca372f48d39b598df768385ac059c171f5e2df7f9a52bc056839" => :mavericks
  end

  keg_only :provided_by_osx,
    "OS X provides BSD units, which behaves differently from GNU units."

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "check"

    ENV.deparallelize # units install otherwise races to make some directories
    system "make", "install"
  end

  test do
    assert_match "6\n",
      shell_output("#{bin}/units '(((square(kiloinch)+2.84m2) /0.5) meters^2)^(1|4)' m").strip
  end
end

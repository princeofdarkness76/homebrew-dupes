class M4 < Formula
  desc "Macro processing language"
  homepage "https://www.gnu.org/software/m4"
  url "http://ftpmirror.gnu.org/m4/m4-1.4.17.tar.xz"
  mirror "https://ftp.gnu.org/gnu/m4/m4-1.4.17.tar.xz"
  sha256 "f0543c3beb51fa6b3337d8025331591e0e18d8ec2886ed391f1aade43477d508"

  bottle do
    cellar :any_skip_relocation
    sha256 "e45bb042581245da6b5ada6889ca57505ca739af5ec01cef26da7369cf4220f7" => :el_capitan
    sha256 "f27b48a9db5c80ee0fad2bc10d7a9b861e0082bb02be6522d013f327b92612ae" => :yosemite
    sha256 "c5486b8a87ba411b23cb0bb8d6d8939a0dbfb717e504a40b10eab2caefdef90e" => :mavericks
  end

  keg_only :provided_by_osx

  def install
    system "./configure", "--disable-dependency-tracking", "--prefix=#{prefix}"
    system "make"
    system "make", "install"
  end

  test do
    assert_match "Homebrew",
      pipe_output("#{bin}/m4", "define(TEST, Homebrew)\nTEST\n")
  end
end

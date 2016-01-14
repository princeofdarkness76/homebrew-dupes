class Libpcap < Formula
  desc "Portable library for network traffic capture"
  homepage "http://www.tcpdump.org/"
  url "http://www.tcpdump.org/release/libpcap-1.7.4.tar.gz"
  sha256 "7ad3112187e88328b85e46dce7a9b949632af18ee74d97ffc3f2b41fe7f448b0"
  head "git://bpf.tcpdump.org/libpcap"

  bottle do
    cellar :any
    revision 1
    sha256 "a4bcec4f3744f8d79246f8bf08f050c5ead1282bb84cbfee8781adda8be9d067" => :el_capitan
    sha256 "6d61bd2683252f7791b581e8ca0743663c70f5ccd7b6900b330b6ae51b09fe56" => :yosemite
    sha256 "01d4bcd4a4bebcd0cf5131a6bf49aba5efc19c7de5ffacda684f5655ea0126b4" => :mavericks
  end

  keg_only :provided_by_osx

  def install
    system "./configure", "--prefix=#{prefix}",
                          "--enable-ipv6",
                          "--disable-universal"
    system "make", "install"
  end

  test do
    assert_match /lpcap/, shell_output("#{bin}/pcap-config --libs")
  end
end

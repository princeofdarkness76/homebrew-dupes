class Lapack < Formula
  desc "Linear Algebra PACKage"
  homepage "http://www.netlib.org/lapack/"
  url "http://www.netlib.org/lapack/lapack-3.6.0.tgz"
  sha256 "a9a0082c918fe14e377bbd570057616768dca76cbdc713457d8199aaa233ffc3"

  bottle do
    sha256 "4d50be768258fdc71923746dbd4c0f3ae0a26eb7d748d780c23e8926a1bc8f66" => :el_capitan
    sha256 "d5062667c73c67e81d2b8c9d2c9bef5d2226f9bcfa6d8766429f5b3a0318657c" => :yosemite
    sha256 "ea53fdfa5b8c5fa0127ba056e74a3ce2f292a3094c6ea1f85a1d841732e56f05" => :mavericks
  end

  resource "manpages" do
    url "http://netlib.org/lapack/manpages.tgz"
    sha256 "055da7402ea807cc16f6c50b71ac63d290f83a5f2885aa9f679b7ad11dd8903d"
  end

  keg_only :provided_by_osx

  depends_on :fortran
  depends_on "cmake" => :build

  def install
    system "cmake", ".", "-DBUILD_SHARED_LIBS:BOOL=ON", "-DLAPACKE:BOOL=ON", *std_cmake_args
    system "make", "install"
    man.install resource("manpages")
  end

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include "lapacke.h"
      int main() {
        void *p = LAPACKE_malloc(sizeof(char)*100);
        if (p) {
          LAPACKE_free(p);
        }
        return 0;
      }
    EOS
    system ENV.cc, "test.cpp", "-L#{lib}", "-I#{include}", "-llapacke", "-o", "test"
    system "./test"
  end
end

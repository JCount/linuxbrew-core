class GrOsmosdr < Formula
  desc "Osmocom GNU Radio Blocks"
  homepage "https://osmocom.org/projects/sdr/wiki/GrOsmoSDR"
  url "https://cgit.osmocom.org/gr-osmosdr/snapshot/gr-osmosdr-0.1.4.tar.gz"
  mirror "https://github.com/osmocom/gr-osmosdr/archive/v0.1.4.tar.gz"
  sha256 "bcf9a9b1760e667c41a354e8cd41ef911d0929d5e4a18e0594ccb3320d735066"

  bottle do
    cellar :any
    sha256 "c92570bef831045649768a79d12a2e06d1b7b5e9d4e18ce69ba2150ac0ba8a40" => :high_sierra
    sha256 "7b4f3a853419147130560597064428c6db315b09b2dd50156d17667340c567bb" => :sierra
    sha256 "6a3d2af506cfd804dbd92c01d110a3fb850b51b37bb1e2faafc328e95b686992" => :el_capitan
  end

  depends_on "cmake" => :build
  depends_on "swig" => :build
  depends_on "airspy"
  depends_on "boost"
  depends_on "gnuradio"
  depends_on "hackrf"
  depends_on "librtlsdr"
  depends_on "python"
  depends_on "uhd"

  resource "Cheetah" do
    url "https://files.pythonhosted.org/packages/source/C/Cheetah/Cheetah-2.4.4.tar.gz"
    sha256 "be308229f0c1e5e5af4f27d7ee06d90bb19e6af3059794e5fd536a6f29a9b550"
  end

  def install
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python2.7/site-packages"

    resource("Cheetah").stage do
      system "python", *Language::Python.setup_install_args(libexec/"vendor")
    end

    system "cmake", ".", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<~EOS
      #include <osmosdr/device.h>
      int main() {
        osmosdr::device_t device();
        return 0;
      }
    EOS
    system ENV.cc, "test.cpp", "-L#{lib}", "-lgnuradio-osmosdr", "-o", "test"
    system "./test"
  end
end

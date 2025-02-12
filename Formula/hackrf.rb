class Hackrf < Formula
  desc "Low cost software radio platform"
  homepage "https://github.com/mossmann/hackrf"
  url "https://github.com/mossmann/hackrf/archive/v2018.01.1.tar.gz"
  sha256 "84dbb5536d3aa5bd6b25d50df78d591e6c3431d752de051a17f4cb87b7963ec3"
  license "GPL-2.0"
  head "https://github.com/mossmann/hackrf.git"

  livecheck do
    url "https://github.com/mossmann/hackrf/releases/latest"
    regex(%r{href=.*?/tag/v?(\d+(?:\.\d+)+)["' >]}i)
  end

  bottle do
    cellar :any
    sha256 "fafc41d9d60bcfee157d7b30efc8ea97b507ad20135f60479ae9840235bae2ad" => :big_sur
    sha256 "4004e867109e43fb7f9613c01a99ffd3d8dee0949d6f27232b06bf740d1e1776" => :catalina
    sha256 "9c0610e7d8fe8f1e840b38d3ce6eeab741842a95f227025fbca24c417ae30549" => :mojave
    sha256 "430173362cc05912520a38f41ce465a0966f1c8d849fd492f0b40074425c3f88" => :high_sierra
    sha256 "f33bc6bde41e6522d587bc574c01e1402ccbde6759dec5e9d1a1e5f593e189b3" => :sierra
    sha256 "909a5a9aca6f81cbab08bb7c063f3ee0e666bb5b44af86ebbec62cbdaf3e3b33" => :el_capitan
    sha256 "424592f91e9c431fe5580e9051d1ce9f9d56af2185b6ae928be83553e936833d" => :x86_64_linux
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "fftw"
  depends_on "libusb"

  def install
    cd "host" do
      args = std_cmake_args
      unless OS.mac?
        args << "-DUDEV_RULES_GROUP=plugdev"
        args << "-DUDEV_RULES_PATH=#{lib}/udev/rules.d"
      end
      system "cmake", ".", *args
      system "make", "install"
    end
  end

  test do
    shell_output("#{bin}/hackrf_transfer", 1)
  end
end

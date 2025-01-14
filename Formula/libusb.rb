class Libusb < Formula
  desc "Library for USB device access"
  homepage "https://libusb.info/"
  url "https://github.com/libusb/libusb/releases/download/v1.0.23/libusb-1.0.23.tar.bz2"
  sha256 "db11c06e958a82dac52cf3c65cb4dd2c3f339c8a988665110e0d24d19312ad8d"
  license "LGPL-2.1"

  livecheck do
    url "https://github.com/libusb/libusb/releases/latest"
    regex(%r{href=.*?/tag/v?(\d+(?:\.\d+)+)["' >]}i)
  end

  bottle do
    cellar :any
    rebuild 1
    sha256 "6ed842c2a0f70a27dd6b65e71e09e66294da8377d1cc06dfec118e31e7f96a0b" => :big_sur
    sha256 "cbfd8044e5e595fcee3cbf62edac4b626a8c623be53ed76e7111fa235ff97668" => :catalina
    sha256 "6dd71c1bc0bbe67ee8f76fb01d33d805bde20b7182695e338e080c9d443029a6" => :mojave
    sha256 "312ca96b255aa045cd2c87150c58e020f49d50e7f354219d944a37de8ec0278c" => :high_sierra
    sha256 "48d8e029c40d50e3e549a30a04814c8f23b30e61c6769fb1f4944128f614129f" => :x86_64_linux
  end

  head do
    url "https://github.com/libusb/libusb.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  depends_on "systemd" if OS.linux? # for libudev

  def install
    args = %W[--disable-dependency-tracking --prefix=#{prefix}]

    system "./autogen.sh" if build.head?
    system "./configure", *args
    system "make", "install"
    (pkgshare/"examples").install Dir["examples/*"] - Dir["examples/Makefile*"]
  end

  test do
    cp_r (pkgshare/"examples"), testpath
    cd "examples" do
      system ENV.cc, "-L#{lib}", "-I#{include}/libusb-1.0",
             "listdevs.c", "-o", "test", "-lusb-1.0"
      system "./test"
    end
  end
end

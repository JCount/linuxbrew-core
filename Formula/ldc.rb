class Ldc < Formula
  desc "Portable D programming language compiler"
  homepage "https://wiki.dlang.org/LDC"
  url "https://github.com/ldc-developers/ldc/releases/download/v1.24.0/ldc-1.24.0-src.tar.gz"
  sha256 "fd9561ade916e9279bdcc166cf0e4836449c24e695ab4470297882588adbba3c"
  license "BSD-3-Clause"
  head "https://github.com/ldc-developers/ldc.git", shallow: false

  livecheck do
    url "https://github.com/ldc-developers/ldc/releases/latest"
    regex(%r{href=.*?/tag/v?(\d+(?:\.\d+)+)["' >]}i)
  end

  bottle do
    sha256 "50fbf7f844bdbf0b7ddadfd4e028509192fe0c12f7c2dfafd57158d649856a82" => :catalina
    sha256 "fbb02c825000d7e2d68061d390279769eb0ee332f8dffc5fabb405e42df0dee6" => :mojave
    sha256 "64cd2a36a85803fe72ee075f35b1a71d4e5f3ddf06115c8885df72874abfec0d" => :high_sierra
    sha256 "7b85dc2f7ea7f54bae4b665a5751ac7ddb2c4f43e32d796cdb67e6dcf20b6a16" => :x86_64_linux
  end

  depends_on "cmake" => :build
  depends_on "libconfig" => :build
  depends_on "llvm@9" # due to a bug in llvm 10 https://bugs.llvm.org/show_bug.cgi?id=47226

  uses_from_macos "libxml2" => :build

  on_linux do
    depends_on "pkg-config" => :build
  end

  resource "ldc-bootstrap" do
    on_macos do
      url "https://github.com/ldc-developers/ldc/releases/download/v1.24.0/ldc2-1.24.0-osx-x86_64.tar.xz"
      sha256 "91b74856982d4d5ede6e026f24e33887d931db11b286630554fc2ad0438cda44"
    end

    on_linux do
      url "https://github.com/ldc-developers/ldc/releases/download/v1.24.0/ldc2-1.24.0-linux-x86_64.tar.xz"
      sha256 "868e070fe90b06549f5fb19882a58a920c0052fad29b764eee9f409f08892ba3"
    end
  end

  def install
    # Fix the error:
    # CMakeFiles/LDCShared.dir/build.make:68: recipe for target 'dmd2/id.h' failed
    ENV.deparallelize unless OS.mac?

    ENV.cxx11
    (buildpath/"ldc-bootstrap").install resource("ldc-bootstrap")

    # Fix ldc-bootstrap/bin/ldmd2: error while loading shared libraries: libxml2.so.2
    ENV.prepend_path "LD_LIBRARY_PATH", Formula["libxml2"].lib

    mkdir "build" do
      args = std_cmake_args + %W[
        -DLLVM_ROOT_DIR=#{Formula["llvm@9"].opt_prefix}
        -DINCLUDE_INSTALL_DIR=#{include}/dlang/ldc
        -DD_COMPILER=#{buildpath}/ldc-bootstrap/bin/ldmd2
      ]

      system "cmake", "..", *args
      system "make"
      system "make", "install"
    end
  end

  test do
    (testpath/"test.d").write <<~EOS
      import std.stdio;
      void main() {
        writeln("Hello, world!");
      }
    EOS
    system bin/"ldc2", "test.d"
    assert_match "Hello, world!", shell_output("./test")
    # Fix Error: The LLVMgold.so plugin (needed for LTO) was not found.
    if OS.mac?
      system bin/"ldc2", "-flto=thin", "test.d"
      assert_match "Hello, world!", shell_output("./test")
      system bin/"ldc2", "-flto=full", "test.d"
      assert_match "Hello, world!", shell_output("./test")
    end
    system bin/"ldmd2", "test.d"
    assert_match "Hello, world!", shell_output("./test")
  end
end

class Flux < Formula
  desc "Lightweight scripting language for querying databases"
  homepage "https://www.influxdata.com/products/flux/"
  url "https://github.com/influxdata/flux.git",
      tag:      "v0.98.0",
      revision: "c40321a5a49949ec65906064251e419fdee4a2ef"
  license "MIT"
  head "https://github.com/influxdata/flux.git"

  livecheck do
    url "https://github.com/influxdata/flux/releases/latest"
    regex(%r{href=.*?/tag/v?(\d+(?:\.\d+)+)["' >]}i)
  end

  bottle do
    cellar :any
    sha256 "367caf1fccf26f51eacae8f3b196b4e1379291eb8319154e7c2975d0c4d7864a" => :big_sur
    sha256 "9778ae0370bf3af6c75d122fc34cc256c443b375924036dd9010b4300cfdce84" => :catalina
    sha256 "2020fabfca64466ddc2d60afd7b41c67a33e7c85dddc3a6ff768943ee6cc6568" => :mojave
    sha256 "cac89e76cf5fbecb76d3d13065c8a6130af6aaf70a8bae656ecb3e72fbd9bc91" => :x86_64_linux
  end

  depends_on "go" => :build
  depends_on "rust" => :build

  on_linux do
    depends_on "llvm" => :build
    depends_on "pkg-config" => :build
    depends_on "ragel" => :build
  end

  def install
    system "make", "build"
    system "go", "build", "./cmd/flux"
    bin.install %w[flux]
    include.install "libflux/include/influxdata"
    on_macos do
      lib.install "libflux/target/x86_64-apple-darwin/release/libflux.dylib"
      lib.install "libflux/target/x86_64-apple-darwin/release/libflux.a"
    end
    on_linux do
      lib.install "libflux/target/x86_64-unknown-linux-gnu/release/libflux.so"
      lib.install "libflux/target/x86_64-unknown-linux-gnu/release/libflux.a"
    end
  end

  test do
    assert_equal "8\n", shell_output("flux execute \"5.0 + 3.0\"")
  end
end

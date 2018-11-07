class Dub < Formula
  desc "Build tool for D projects"
  homepage "https://code.dlang.org/getting_started"
  url "https://github.com/dlang/dub/archive/v1.12.0.tar.gz"
  sha256 "0c087eb98c9f251c36e54144a9258d53c6b9abf8b7481cecbf7461b7759627b9"
  version_scheme 1
  head "https://github.com/dlang/dub.git"

  devel do
    url "https://github.com/dlang/dub/archive/v1.6.0-beta.2.tar.gz"
    sha256 "da1877c7c39a4905bca78083784733bfae59d60c7b665169d87fe2d81651b38f"
  end

  bottle do
    sha256 "82636980a98589818a65a844f5549fdb8114f74f792ce08c1fe39bf3d3b489b4" => :mojave
    sha256 "c3acb05edca5afae5722aea2b07d8c7645f54d8b87e8edb419ef8da411008fd2" => :high_sierra
    sha256 "7759e0daa3f929cfbbe892c3f07bfd25f5fe2a85a8f14e5875e309b79e223ceb" => :sierra
    sha256 "8deb6bd24f829d0f6f68a68fb2b8704de6ac036ebb9504bb8270393dda47b0c9" => :x86_64_linux
  end

  depends_on "dmd" => :build
  depends_on "pkg-config" => :recommended
  depends_on "curl" unless OS.mac?

  def install
    ENV["GITVER"] = version.to_s
    system "./build.sh"
    bin.install "bin/dub"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/dub --version").split(/[ ,]/)[2]
  end
end

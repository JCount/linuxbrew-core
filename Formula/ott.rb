class Ott < Formula
  desc "Tool for writing definitions of programming languages and calculi"
  homepage "https://www.cl.cam.ac.uk/~pes20/ott/"
  url "https://github.com/ott-lang/ott/archive/0.31.tar.gz"
  sha256 "3203f1b3eeb30e6aead9f63f6df22f5ead2407964ac9bb3cd5b0ae78df4568f8"
  license "BSD-3-Clause"
  revision 1
  head "https://github.com/ott-lang/ott.git"

  livecheck do
    url "https://github.com/ott-lang/ott/releases/latest"
    regex(%r{href=.*?/tag/v?(\d+(?:\.\d+)+)["' >]}i)
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "b1b1f04443bb7645a23898cb98a1308ebbf3033b2d9054e027ed59b722d6850b" => :big_sur
    sha256 "22f441ac37e494c9b667838b43e87f820dcf2fe090c4794db7eb0cc3cbd514a6" => :catalina
    sha256 "7f4274253521ef41f38b674247906a6f9567dce515c80a5150111a1da0dc5caf" => :mojave
    sha256 "a59bb92116efa3e1b7c13da59a95dd7ad7a2618c6efc4b09d74a59001478bde5" => :high_sierra
    sha256 "f04fbb34cb6bca85d8b80072276397bbdf383beb49a8954498b2d10e6c052a23" => :x86_64_linux
  end

  depends_on "ocaml" => :build

  def install
    system "make", "world"
    bin.install "bin/ott"
    pkgshare.install "examples"
    (pkgshare/"emacs/site-lisp/ott").install "emacs/ott-mode.el"
  end

  test do
    system "#{bin}/ott", "-i", pkgshare/"examples/peterson_caml.ott",
      "-o", "peterson_caml.tex", "-o", "peterson_caml.v"
  end
end

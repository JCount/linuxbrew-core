require "language/node"

class Gitmoji < Formula
  desc "Emoji guide for your commit messages"
  homepage "https://gitmoji.carloscuesta.me"
  url "https://registry.npmjs.org/gitmoji-cli/-/gitmoji-cli-3.2.13.tgz"
  sha256 "519cee53a23b2230254d653cf3786f9db834f6689fa11f4db754669219640a59"
  license "MIT"

  livecheck do
    url :stable
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "4ab375f4a6ccb42fe06b7df8028edef3c148d0ce7edeab88f7c919e1f8f8406e" => :big_sur
    sha256 "efcf9af4133249d05960fcd69ebed10c09307967a843464b398081f1a32c6785" => :catalina
    sha256 "1e32af5596af98140aa0bae4e8a8e92177684fb6c077f96d057f973b5a312198" => :mojave
    sha256 "8b0d9392bee428062272b9aa28ea601818b8481cb1449aba1e4b681cc18d8b09" => :x86_64_linux
  end

  depends_on "node"

  def install
    system "npm", "install", *Language::Node.std_npm_install_args(libexec)
    bin.install_symlink Dir["#{libexec}/bin/*"]
  end

  test do
    assert_match ":bug:", shell_output("#{bin}/gitmoji --search bug")
  end
end

class Ripgrep < Formula
  desc "Search tool like grep and The Silver Searcher"
  homepage "https://github.com/BurntSushi/ripgrep"
  url "https://github.com/BurntSushi/ripgrep/archive/12.1.1.tar.gz"
  sha256 "2513338d61a5c12c8fea18a0387b3e0651079ef9b31f306050b1f0aaa926271e"
  license "Unlicense"
  revision 1 unless OS.mac?
  head "https://github.com/BurntSushi/ripgrep.git"

  livecheck do
    url "https://github.com/BurntSushi/ripgrep/releases/latest"
    regex(%r{href=.*?/tag/v?(\d+(?:\.\d+)+)["' >]}i)
  end

  bottle do
    sha256 "0ca7397f9a0ccef6cbb8ff0fd8fb18c6fe86219abaef350e3d7ef248d07440fd" => :big_sur
    sha256 "60460d422253113af3ed60332104f309638942821c655332211a6bc2213c472c" => :catalina
    sha256 "de4b18789f5d9bc4aaa4d906501200ae4ece7a1971dd1b86e2b2d0a2c8e0d764" => :mojave
    sha256 "cfea5335bf4eccfb7cd1d93bec234d96bd49dce8d593ea966687f777909ba291" => :high_sierra
    sha256 "cc67012f7306715752197e382b04dd3e1edce1c5161b9c7c0fd5df25a943fe16" => :x86_64_linux
  end

  depends_on "asciidoctor" => :build
  depends_on "pkg-config" => :build
  depends_on "rust" => :build
  depends_on "pcre2"

  def install
    system "cargo", "install", "--features", "pcre2", *std_cargo_args

    # Completion scripts and manpage are generated in the crate's build
    # directory, which includes a fingerprint hash. Try to locate it first
    out_dir = Dir["target/release/build/ripgrep-*/out"].first
    man1.install "#{out_dir}/rg.1"
    bash_completion.install "#{out_dir}/rg.bash"
    fish_completion.install "#{out_dir}/rg.fish"
    zsh_completion.install "complete/_rg"
  end

  test do
    (testpath/"Hello.txt").write("Hello World!")
    system "#{bin}/rg", "Hello World!", testpath
  end
end

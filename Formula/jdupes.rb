class Jdupes < Formula
  desc "Duplicate file finder and an enhanced fork of 'fdupes'"
  homepage "https://github.com/jbruchon/jdupes"
  url "https://github.com/jbruchon/jdupes/archive/v1.19.1.tar.gz"
  sha256 "bb7c53cd463ab5e21da85948c4662a3b7ac9b038ae993cc14ccf793d2472e2e9"
  license "MIT"

  livecheck do
    url "https://github.com/jbruchon/jdupes/releases/latest"
    regex(%r{href=.*?/tag/v?(\d+(?:\.\d+)+)["' >]}i)
  end

  bottle do
    cellar :any_skip_relocation
    sha256 "bf871f37dcb362d686dd45943fe9c99450f1c63a87cd5609b9c3a87f70c3fc84" => :big_sur
    sha256 "e45323a13531cfbe654f20187dfc34439979748e9f19c8b31c3adf8fc500e289" => :catalina
    sha256 "3480a8d00c48aebfe2372034f5da4a9864a4a58afdda59ecd24420459726f6fc" => :mojave
    sha256 "02228d9468728ee247f00e915a63cb661a32390d937db7f151b8e681347c5a4b" => :x86_64_linux
  end

  def install
    system "make", "install", "PREFIX=#{prefix}", "ENABLE_DEDUPE=1"
  end

  test do
    touch "a"
    touch "b"
    (testpath/"c").write("unique file")
    dupes = shell_output("#{bin}/jdupes --zeromatch .").strip.split("\n").sort
    assert_equal ["./a", "./b"], dupes
  end
end

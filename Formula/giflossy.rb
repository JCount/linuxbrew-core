class Giflossy < Formula
  desc "Lossy LZW compression, reduces GIF file sizes by 30-50%"
  homepage "https://pornel.net/lossygif"
  url "https://github.com/kornelski/giflossy/archive/1.91.tar.gz"
  sha256 "b97f6aadf163ff5dd96ad1695738ad3d5aa7f1658baed8665c42882f11d9ab22"
  license "GPL-2.0"
  head "https://github.com/kornelski/giflossy.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 2
    sha256 "ad63a534a7e83c162d536cb43c421a78b089ca9921e89ed598c8ae13fe7adb1f" => :big_sur
    sha256 "de5ae53cff723bbb5cbe11028d088f028053ebc70a14b6497dd7f5f9ca9651b4" => :catalina
    sha256 "02eeb9a6b44178fdf1df803346dceedda853c7245cd51a1a6166290a73fb51f4" => :mojave
    sha256 "7c0fdff9266b551b503a3e4d94540026eebde2d35dbe33e380bb3b6164a771ac" => :x86_64_linux
  end

  deprecate! because: :repo_archived

  depends_on "autoconf" => :build
  depends_on "automake" => :build

  conflicts_with "gifsicle",
    because: "both install an `gifsicle` binary"

  def install
    args = %W[
      --disable-dependency-tracking
      --prefix=#{prefix}
      --disable-gifview
    ]

    system "autoreconf", "-fvi"
    system "./configure", *args
    system "make", "install"
  end

  test do
    system bin/"gifsicle", "-O3", "--lossy=80", "-o",
                           "out.gif", test_fixtures("test.gif")
  end
end

class Apr < Formula
  desc "Apache Portable Runtime library"
  homepage "https://apr.apache.org/"
  url "https://www.apache.org/dyn/closer.cgi?path=apr/apr-1.7.0.tar.bz2"
  sha256 "e2e148f0b2e99b8e5c6caa09f6d4fb4dd3e83f744aa72a952f94f5a14436f7ea"

  bottle do
    root_url "https://linuxbrew.bintray.com/bottles"
    cellar :any
    sha256 "3a245185ed7280d1a19e7c639786b4c21dd0088878be8ac87ca58510eb5c9cc1" => :mojave
    sha256 "4d01f24009ea389e2c8771c5c0bc069ae09c0f5812d7fdb0d0079106c3fc0838" => :high_sierra
    sha256 "a49a1725c76754297c0f9a268423ee9a1772d23d264360504cc3401a21d2aa7e" => :sierra
    sha256 "55aa3f0c5dcb612e8c201e0ddc63ef52db99f314a14ae0aab4b6f7d6b4f365d3" => :x86_64_linux
  end

  keg_only :provided_by_macos, "Apple's CLT package contains apr"

  depends_on "util-linux" => :recommended if OS.linux? # for libuuid

  def install
    ENV["SED"] = "sed" # prevent libtool from hardcoding sed path from superenv

    # https://bz.apache.org/bugzilla/show_bug.cgi?id=57359
    # The internal libtool throws an enormous strop if we don't do...
    ENV.deparallelize

    if OS.linux? && build.bottle?
      # Prevent hardcoded /usr/bin/gcc-4.8 compiler
      ENV["CC"] = "cc"
    end

    # Stick it in libexec otherwise it pollutes lib with a .exp file.
    system "./configure", "--prefix=#{libexec}"
    system "make", "install"
    bin.install_symlink Dir["#{libexec}/bin/*"]
    lib.install_symlink Dir["#{libexec}/lib/*.so*"] unless OS.mac?

    rm Dir[libexec/"lib/*.la"]

    # No need for this to point to the versioned path.
    inreplace libexec/"bin/apr-1-config", libexec, opt_libexec
  end

  test do
    assert_match opt_libexec.to_s, shell_output("#{bin}/apr-1-config --prefix")
  end
end

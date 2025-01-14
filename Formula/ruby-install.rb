class RubyInstall < Formula
  desc "Install Ruby, JRuby, Rubinius, TruffleRuby, or mruby"
  homepage "https://github.com/postmodern/ruby-install#readme"
  url "https://github.com/postmodern/ruby-install/archive/v0.7.1.tar.gz"
  sha256 "2a082504f81b6017e8f679f093664fff9b6a282f8df4c9eb0a200643be3fcb56"
  license "MIT"
  head "https://github.com/postmodern/ruby-install.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "c81184e66eb30d512f8f6ab320b71a221bffcfacfb5b10e1131d2e559238f237" => :big_sur
    sha256 "2c60a37228f97ef76c4f40c36b1a63d046a5d80acf5dc20d93183b81ccf1317a" => :catalina
    sha256 "2c60a37228f97ef76c4f40c36b1a63d046a5d80acf5dc20d93183b81ccf1317a" => :mojave
    sha256 "2c60a37228f97ef76c4f40c36b1a63d046a5d80acf5dc20d93183b81ccf1317a" => :high_sierra
    sha256 "34a78042a7e8c9d65d32db5bc7fe6692188f81f1c8e4972ce1bd809908c9225e" => :x86_64_linux
  end

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "#{bin}/ruby-install"
  end
end

class Mongoose < Formula
  desc "Web server build on top of Libmongoose embedded library"
  homepage "https://github.com/cesanta/mongoose"
  url "https://github.com/cesanta/mongoose/archive/6.17.tar.gz"
  sha256 "5bff3cc70bb2248cf87d06a3543f120f3b29b9368d25a7715443cb10612987cc"
  license "GPL-2.0-only"

  bottle do
    cellar :any
    sha256 "180bc1cd1f5aecd01ee647be39884eed4bb0985c82beb39076ff1082a1d56a40" => :big_sur
    sha256 "3eb55e73c26957e647dcc4f978fa7d4d5ae2b223fa631d208f07b341d26ac0d5" => :catalina
    sha256 "cb43e1b9e539db8348d6038fbe56ca787b02428f3c585cd0528c3c4521a26222" => :mojave
    sha256 "a65aaee3abb441a26728b8f08c5fa81845f5636d676fadaba5881da4da04ee71" => :high_sierra
    sha256 "8ad47a4321a082f6739ab1085448ba54ca488cd5afc45d5c60e814f3ff4af31f" => :x86_64_linux
  end

  depends_on "openssl@1.1"

  conflicts_with "suite-sparse", because: "suite-sparse vendors libmongoose.dylib"

  def install
    # No Makefile but is an expectation upstream of binary creation
    # https://github.com/cesanta/mongoose/issues/326
    cd "examples/simplest_web_server" do
      system "make"
      bin.install "simplest_web_server" => "mongoose"
    end

    if OS.mac?
      system ENV.cc, "-dynamiclib", "mongoose.c", "-o", "libmongoose.dylib"
      lib.install "libmongoose.dylib"
    else
      system ENV.cc, "-fPIC", "-c", "mongoose.c"
      system ENV.cc, "-shared", "-Wl,-soname,libmongoose.so", "-o", "libmongoose.so", "mongoose.o", "-lc", "-lpthread"
      lib.install "libmongoose.so"
    end
    include.install "mongoose.h"
    pkgshare.install "examples", "jni"
    doc.install Dir["docs/*"]
  end

  test do
    (testpath/"hello.html").write <<~EOS
      <!DOCTYPE html>
      <html>
        <head>
          <title>Homebrew</title>
        </head>
        <body>
          <p>Hi!</p>
        </body>
      </html>
    EOS

    begin
      pid = fork { exec "#{bin}/mongoose" }
      sleep 2
      assert_match "Hi!", shell_output("curl http://localhost:8000/hello.html")
    ensure
      Process.kill("SIGINT", pid)
      Process.wait(pid)
    end
  end
end

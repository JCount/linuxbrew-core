class Mitmproxy < Formula
  include Language::Python::Virtualenv

  desc "Intercept, modify, replay, save HTTP/S traffic"
  homepage "https://mitmproxy.org"
  url "https://github.com/mitmproxy/mitmproxy/archive/v3.0.4.tar.gz"
  sha256 "37576d8d912aadc6c8f8da225e7b4a8dac0000c004c89e4ead3ad6e8cbe32ad7"
  head "https://github.com/mitmproxy/mitmproxy.git"

  bottle do
    cellar :any
    sha256 "a21db52013c363b12e341f08ec4a94a014236b970677c87920da317ab2714190" => :high_sierra
    sha256 "832351e6104ee1d7a23452dc29e4d5874f8eb2c87960b2f3ba60c6c4e799a652" => :sierra
    sha256 "8b69ea243997f3787c85a4e6f49393ac8a2b6d40b708e205d5fddccd9d0be201" => :el_capitan
  end

  depends_on "openssl"
  depends_on "python"
  depends_on "protobuf"
  unless OS.mac?
    depends_on "libffi"
    # pkg-config helps setuptools find libffi
    depends_on "pkg-config" => :build
  end

  resource "asn1crypto" do
    url "https://files.pythonhosted.org/packages/fc/f1/8db7daa71f414ddabfa056c4ef792e1461ff655c2ae2928a2b675bfed6b4/asn1crypto-0.24.0.tar.gz"
    sha256 "9d5c20441baf0cb60a4ac34cc447c6c189024b6b4c6cd7877034f4965c464e49"
  end

  resource "blinker" do
    url "https://files.pythonhosted.org/packages/1b/51/e2a9f3b757eb802f61dc1f2b09c8c99f6eb01cf06416c0671253536517b6/blinker-1.4.tar.gz"
    sha256 "471aee25f3992bd325afa3772f1063dbdbbca947a041b8b89466dc00d606f8b6"
  end

  resource "brotlipy" do
    url "https://files.pythonhosted.org/packages/d9/91/bc79b88590e4f662bd40a55a2b6beb0f15da4726732efec5aa5a3763d856/brotlipy-0.7.0.tar.gz"
    sha256 "36def0b859beaf21910157b4c33eb3b06d8ce459c942102f16988cca6ea164df"
  end

  resource "certifi" do
    url "https://files.pythonhosted.org/packages/15/d4/2f888fc463d516ff7bf2379a4e9a552fef7f22a94147655d9b1097108248/certifi-2018.1.18.tar.gz"
    sha256 "edbc3f203427eef571f79a7692bb160a2b0f7ccaa31953e99bd17e307cf63f7d"
  end

  resource "cffi" do
    url "https://files.pythonhosted.org/packages/e7/a7/4cd50e57cc6f436f1cc3a7e8fa700ff9b8b4d471620629074913e3735fb2/cffi-1.11.5.tar.gz"
    sha256 "e90f17980e6ab0f3c2f3730e56d1fe9bcba1891eeea58966e89d352492cc74f4"
  end

  resource "click" do
    url "https://files.pythonhosted.org/packages/95/d9/c3336b6b5711c3ab9d1d3a80f1a3e2afeb9d8c02a7166462f6cc96570897/click-6.7.tar.gz"
    sha256 "f15516df478d5a56180fbf80e68f206010e6d160fc39fa508b65e035fd75130b"
  end

  resource "cryptography" do
    url "https://files.pythonhosted.org/packages/ec/b2/faa78c1ab928d2b2c634c8b41ff1181f0abdd9adf9193211bd606ffa57e2/cryptography-2.2.2.tar.gz"
    sha256 "9fc295bf69130a342e7a19a39d7bbeb15c0bcaabc7382ec33ef3b2b7d18d2f63"
  end

  resource "h11" do
    url "https://files.pythonhosted.org/packages/50/13/954a4bd263857262a0b07155b47f5494a02b97984a5bcc6263bf89f12586/h11-0.7.0.zip"
    sha256 "1c0fbb1cba6f809fe3e6b27f8f6d517ca171f848922708871403636143d530d9"
  end

  resource "h2" do
    url "https://files.pythonhosted.org/packages/3c/86/aebb88df3c87255cfd0ffd338608fbfb34d1c850750a486e7f05b013e5a3/h2-3.0.1.tar.gz"
    sha256 "b2962f883fa392a23cbfcc4ad03c335bcc661be0cf9627657b589f0df2206e64"
  end

  resource "hpack" do
    url "https://files.pythonhosted.org/packages/44/f1/b4440e46e265a29c0cb7b09b6daec6edf93c79eae713cfed93fbbf8716c5/hpack-3.0.0.tar.gz"
    sha256 "8eec9c1f4bfae3408a3f30500261f7e6a65912dc138526ea054f9ad98892e9d2"
  end

  resource "hyperframe" do
    url "https://files.pythonhosted.org/packages/a4/59/dddaddc73b4d53e9649850998e23b6daca80817c5442465a12423235d20b/hyperframe-5.1.0.tar.gz"
    sha256 "a25944539db36d6a2e47689e7915dcee562b3f8d10c6cdfa0d53c91ed692fb04"
  end

  resource "idna" do
    url "https://files.pythonhosted.org/packages/f4/bd/0467d62790828c23c47fc1dfa1b1f052b24efdf5290f071c7a91d0d82fd3/idna-2.6.tar.gz"
    sha256 "2c6a5de3089009e3da7c5dde64a141dbc8551d5b7f6cf4ed7c2568d0cc520a8f"
  end

  resource "kaitaistruct" do
    url "https://files.pythonhosted.org/packages/23/71/8577ca06e81c1dc0ba03a39ae32e315175ba2d9df51befa3a45f47950056/kaitaistruct-0.8.tar.gz"
    sha256 "d1d17c7f6839b3d28fc22b21295f787974786c2201e8788975e72e2a1d109ff5"
  end

  resource "ldap3" do
    url "https://files.pythonhosted.org/packages/24/36/89162b1b2245031b17d52a2100758c32bf1ac0b1cf0b51014ad2d10bb01c/ldap3-2.4.1.tar.gz"
    sha256 "e8fe0d55a8cecb725748c831ffac2873df94c05b2d7eb867ea167c0500bbc6a8"
  end

  resource "passlib" do
    url "https://files.pythonhosted.org/packages/25/4b/6fbfc66aabb3017cd8c3bd97b37f769d7503ead2899bf76e570eb91270de/passlib-1.7.1.tar.gz"
    sha256 "3d948f64138c25633613f303bcc471126eae67c04d5e3f6b7b8ce6242f8653e0"
  end

  resource "pyasn1" do
    url "https://files.pythonhosted.org/packages/eb/3d/b7d0fdf4a882e26674c68c20f40682491377c4db1439870f5b6f862f76ed/pyasn1-0.4.2.tar.gz"
    sha256 "d258b0a71994f7770599835249cece1caef3c70def868c4915e6e5ca49b67d15"
  end

  resource "pycparser" do
    url "https://files.pythonhosted.org/packages/8c/2d/aad7f16146f4197a11f8e91fb81df177adcc2073d36a17b1491fd09df6ed/pycparser-2.18.tar.gz"
    sha256 "99a8ca03e29851d96616ad0404b4aad7d9ee16f25c9f9708a11faf2810f7b226"
  end

  resource "pyOpenSSL" do
    url "https://files.pythonhosted.org/packages/3b/15/a5d90ab1a41075e8f0fae334f13452549528f82142b3b9d0c9d86ab7178c/pyOpenSSL-17.5.0.tar.gz"
    sha256 "2c10cfba46a52c0b0950118981d61e72c1e5b1aac451ca1bc77de1a679456773"
  end

  resource "pyparsing" do
    url "https://files.pythonhosted.org/packages/3c/ec/a94f8cf7274ea60b5413df054f82a8980523efd712ec55a59e7c3357cf7c/pyparsing-2.2.0.tar.gz"
    sha256 "0832bcf47acd283788593e7a0f542407bd9550a55a8a8435214a1960e04bcb04"
  end

  resource "pyperclip" do
    url "https://files.pythonhosted.org/packages/5b/06/86e3c6a55cacef0e4ec7c25379ff7fcd1a88fd939ecefd442b535c792fa4/pyperclip-1.6.0.tar.gz"
    sha256 "ce829433a9af640e08ee89b20f7c62132714bcc5d77df114044d0fccb8c3b3b8"
  end

  resource "ruamel.yaml" do
    url "https://files.pythonhosted.org/packages/c1/ad/9557a78f1b61951623c56225e05dacdd81f80519f13fc39a926a5793edfa/ruamel.yaml-0.15.37.tar.gz"
    sha256 "509842d96fb194f79b57483b76429f8956d8f7ade3cb49d1e5aeb5c5e9ef4918"
  end

  resource "six" do
    url "https://files.pythonhosted.org/packages/16/d8/bc6316cf98419719bd59c91742194c111b6f2e85abac88e496adefaf7afe/six-1.11.0.tar.gz"
    sha256 "70e8a77beed4562e7f14fe23a786b54f6296e34344c23bc42f07b15018ff98e9"
  end

  resource "sortedcontainers" do
    url "https://files.pythonhosted.org/packages/64/c8/709e55ef31b56ab6920d8680e27812ddfc0b2be76502aad39ad9f5f507e4/sortedcontainers-1.5.9.tar.gz"
    sha256 "844daced0f20d75c02ce53f373d048ea2e401ad8a7b3a4c43b2aa544b569efb3"
  end

  resource "tornado" do
    url "https://files.pythonhosted.org/packages/66/60/5b34caa5014eb3f1deb16d0e72cc08abeec7a9c9823486da7984ddadc95f/tornado-5.0.1.tar.gz"
    sha256 "3e9a2333362d3dad7876d902595b64aea1a2f91d0df13191ea1f8bca5a447771"
  end

  resource "urwid" do
    url "https://files.pythonhosted.org/packages/c7/90/415728875c230fafd13d118512bde3184d810d7bf798a631abc05fac09d0/urwid-2.0.1.tar.gz"
    sha256 "644d3e3900867161a2fc9287a9762753d66bd194754679adb26aede559bcccbc"
  end

  resource "wsproto" do
    url "https://files.pythonhosted.org/packages/8a/8e/65017baa6a398f93866c68054ce797aef1a8b10793c94d8653f70e8ad613/wsproto-0.11.0.tar.gz"
    sha256 "02f214f6bb43cda62a511e2e8f1d5fa4703ed83d376d18d042bd2bbf2e995824"
  end

  def install
    # Reduce memory usage below 4 GB for Circle CI.
    ENV["MAKEFLAGS"] = "-j4 -l2.5" if ENV["CIRCLECI"]

    venv = virtualenv_create(libexec, "python3")
    venv.pip_install resources
    venv.pip_install_and_link buildpath
  end

  test do
    ENV["LANG"] = "en_US.UTF-8"
    assert_match version.to_s, shell_output("#{bin}/mitmproxy --version 2>&1")
  end
end

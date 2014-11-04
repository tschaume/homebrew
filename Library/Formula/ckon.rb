require "formula"

class Ckon < Formula
  homepage "http://tschaume.github.io/ckon/"
  url "https://github.com/tschaume/ckon/archive/v0.7.tar.gz"
  sha1 "ffaddc95f768cd4d4157bcac090f87a41f72f00c"

  depends_on "boost"
  depends_on "curl"
  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  def install
    system "./autogen.sh"
    autoreconf_args = ["-v", "--force", "--install", "-Wall"]
    system "autoreconf", *autoreconf_args
    boostopts = [
      "--with-boost", "--with-boost-filesystem",
      "--with-boost-system", "--with-boost-regex",
      "--with-boost-program-options"
    ]
    system "./configure", "--prefix=#{prefix}", *boostopts
    # ENV.deparallelize
    system "make", "install"
  end

  test do
    system bin/"ckon", "--version"
  end
end

require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Xhprof < AbstractPhp72Extension
  init
  desc "XHProf is a function-level hierarchical profiler for PHP and has a simple HTML based user interface."
  homepage "https://github.com/longxinH/xhprof"
  url "https://github.com/longxinH/xhprof/archive/87735837d37ebfc82cb7a02dc28bbf66f74540ef.tar.gz"
  sha256 "6f2fbf9e4bf4199208b7cd5c0f6ce5677290488f255e4eb89953866177fcf812"
  head "https://github.com/longxinH/xhprof.git"
  version "8773583"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "324b1a1dffac750172d3e0dbd1a1ba89117b54b9e1499fa61e6b68f66b328b75" => :el_capitan
    sha256 "a34fee24d050b1cdb5096e592c3dcd7e9df52f43c2c38611d5dc5e3a90a62d7e" => :yosemite
    sha256 "81104762bdf370b7f407ba6c73aa3852bc5694baf7990987f1c8b387c51e1f16" => :mavericks
  end

  depends_on "pcre"

  def install
    Dir.chdir "extension" do
      ENV.universal_binary if build.universal?

      safe_phpize
      system "./configure", "--prefix=#{prefix}",
                            phpconfig
      system "make"
      prefix.install "modules/xhprof.so"
    end

    prefix.install %w[xhprof_html xhprof_lib]
    write_config_file if build.with? "config-file"
  end
end

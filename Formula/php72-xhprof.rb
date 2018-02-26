require File.expand_path("../../Abstract/abstract-php-extension", __FILE__)

class Php72Xhprof < AbstractPhp72Extension
  init
  desc "XHProf is a function-level hierarchical profiler for PHP and has a simple HTML based user interface."
  homepage "https://github.com/longxinH/xhprof"
  url "https://github.com/longxinH/xhprof/archive/v1.2.zip"
  sha256 "f0eaf408631d9b52cb71ff46b93e2eca54966c711f1111f616e0393088361a21"
  head "https://github.com/longxinH/xhprof.git"
  version "1.2"

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

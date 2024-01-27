class Decor < Formula
  desc "Markdown transformer for single page, which uses a HTML file as a template"
  homepage "https://github.com/tai2/decor"
  url "https://github.com/tai2/decor/archive/refs/tags/v1.1.1.tar.gz"
  sha256 "10ab57cf55a03a3e95390e760259d3115268e928638ab133210674d557a010f2"
  license "MIT"

  depends_on "deno"

  def install
    prefix.install "src"
    system "deno", "install", "--allow-read", "--allow-write", "--root", ".", "#{prefix}/src/decor.ts"
    bin.install "bin/decor"
  end

  test do
    (testpath/"test.md").write <<~EOS
      # A markdown file

      This is an *example* content
    EOS

    system "#{bin}/decor", testpath/"test.md", "--output", testpath/"test.html"
    assert_predicate testpath/"test.html", :exist?
  end
end

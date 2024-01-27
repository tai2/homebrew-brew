class Decor < Formula
  desc "Markdown transformer for single page, which uses a HTML file as a template"
  homepage "https://github.com/tai2/decor"
  url "https://github.com/tai2/decor/archive/refs/tags/v1.1.3.tar.gz"
  sha256 "2c11d45e71a432befbd2034b06a6093c9f334929a854c2156e7d5eef72508d52"
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

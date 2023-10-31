class Decor < Formula
  desc "Markdown transformer for single page, which uses a HTML file as a template"
  homepage "https://github.com/tai2/decor"
  url "https://github.com/tai2/decor/archive/refs/tags/v0.0.6.tar.gz"
  sha256 "7dc5fe77a8f88e8bf4fde2af028b3580d8ef3cd23f89cce4509424a3a98b72fe"
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

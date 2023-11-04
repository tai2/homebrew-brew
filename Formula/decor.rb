class Decor < Formula
  desc "Markdown transformer for single page, which uses a HTML file as a template"
  homepage "https://github.com/tai2/decor"
  url "https://github.com/tai2/decor/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "d4563a8f743c581e57c141ecbda58bc3c5b7d58aaca027d89f00907865275bef"
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

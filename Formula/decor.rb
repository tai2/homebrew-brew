class Decor < Formula
  desc "Markdown transformer for single page, which uses a HTML file as a template"
  homepage "https://github.com/tai2/decor"
  url "https://github.com/tai2/decor/archive/refs/tags/v1.0.4.tar.gz"
  sha256 "f254d2687dc51c4f41ddc6bd8cf8df4db99e2bb97c627625b669b941ae419676"
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

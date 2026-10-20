class ImifyCli < Formula
  desc "Command-line interface for the imify platform"
  homepage "https://imify.ai"
  version "0.3.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/imify-ai/imify-cli/releases/download/v0.3.0/imify-cli-aarch64-apple-darwin.tar.xz"
      sha256 "76c43c149e1293c2548f5a13161f228224259510f9873744c58de85bb00e8ad8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/imify-ai/imify-cli/releases/download/v0.3.0/imify-cli-x86_64-apple-darwin.tar.xz"
      sha256 "18c27d10598bdbf81fe28ff3c69ce63bf69a32a10f5c0799fa75f246348a47e1"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/imify-ai/imify-cli/releases/download/v0.3.0/imify-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "333d71ee0fbe94fe7f7def1bbb75ef48af3c21be68861b8d4f4cdcc60d09cbca"
    end
    if Hardware::CPU.intel?
      url "https://github.com/imify-ai/imify-cli/releases/download/v0.3.0/imify-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "e77b927ce7cbcbb31405926e6114508868c19fdea562ab0370151a5a9435d694"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "imify"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "imify"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "imify"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "imify"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end

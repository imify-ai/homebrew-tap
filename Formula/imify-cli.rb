class ImifyCli < Formula
  desc "Command-line interface for the imify platform"
  homepage "https://imify.ai"
  version "0.5.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/imify-ai/imify-cli/releases/download/v0.5.1/imify-cli-aarch64-apple-darwin.tar.xz"
      sha256 "f6bb11cf78afac1a5bad0d3abe04d2e0835189ce8cbe1c8ecc6423cab3fe2936"
    end
    if Hardware::CPU.intel?
      url "https://github.com/imify-ai/imify-cli/releases/download/v0.5.1/imify-cli-x86_64-apple-darwin.tar.xz"
      sha256 "67a257e81c0452e3731b97e5b4aa879fc19615c044c4cb51d5a30c81780533fb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/imify-ai/imify-cli/releases/download/v0.5.1/imify-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "4e3e50cdcef3114c1136de5852c72045bb0860c125125bc34b89f5890f88f6ac"
    end
    if Hardware::CPU.intel?
      url "https://github.com/imify-ai/imify-cli/releases/download/v0.5.1/imify-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "d049d24b6334a88d48f0cee38169bc8088a3314c15c76b90fe5236afb50dd16c"
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

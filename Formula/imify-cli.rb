class ImifyCli < Formula
  desc "Command-line interface for the imify platform"
  homepage "https://imify.ai"
  version "0.4.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/imify-ai/imify-cli/releases/download/v0.4.0/imify-cli-aarch64-apple-darwin.tar.xz"
      sha256 "27c5caa0f5e7370fbbea162d03b2796c03c0af34c4f61009ecf16ac4e1ea0ceb"
    end
    if Hardware::CPU.intel?
      url "https://github.com/imify-ai/imify-cli/releases/download/v0.4.0/imify-cli-x86_64-apple-darwin.tar.xz"
      sha256 "feef829b1177e474cf71e8da017721c45a422cb073c103a3179563a15128e481"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/imify-ai/imify-cli/releases/download/v0.4.0/imify-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0822e37d7053e600a3837acc66756abc629199310d7e72da48a45260b805b88e"
    end
    if Hardware::CPU.intel?
      url "https://github.com/imify-ai/imify-cli/releases/download/v0.4.0/imify-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "277c4374e09151f4e5599ef1783111f1469f687427e258d832228e56c08c22fa"
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

class ImifyCli < Formula
  desc "Command-line interface for the imify platform"
  homepage "https://imify.ai"
  version "0.2.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/imify-ai/imify-cli/releases/download/v0.2.0/imify-cli-aarch64-apple-darwin.tar.xz"
      sha256 "a53c42e68c232461c528595ef72b6707727a33de119a3a9a7f5892af505dbc58"
    end
    if Hardware::CPU.intel?
      url "https://github.com/imify-ai/imify-cli/releases/download/v0.2.0/imify-cli-x86_64-apple-darwin.tar.xz"
      sha256 "bccc65f7992f64311ccfc2b7d08778a3d4c8f0ab674aabed06c5ce96c8646151"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/imify-ai/imify-cli/releases/download/v0.2.0/imify-cli-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ff05e6b1ba5f8830b806dfc2cedbafcd703c71271559d288a267503cbe27eadf"
    end
    if Hardware::CPU.intel?
      url "https://github.com/imify-ai/imify-cli/releases/download/v0.2.0/imify-cli-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "52ac8e327a4c3b448a074b94e10cedf0259a0dadadd775498d79ebfcae07176d"
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

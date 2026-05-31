class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.980"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.980/nuon_darwin_amd64"
    sha256 "d64a28c8f46cf2ae59fc99eec6a514467e3a15e4dc6564b41c6baa6d49e36133"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.980/nuon_darwin_arm64"
    sha256 "e8c9ef749a56b4b6c27346599f18f6f9b6f842b5a1a149c84a2058d9b4f1ec7c"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.980/nuon_linux_amd64"
    sha256 "1d9c043ec4f503d40c47bbb9d35b4abd89753d1e86bcef769a9172b842ec232f"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.980/nuon_linux_arm"
    sha256 "59365a0d42a7781a3367765d2c0fe820f8a1742cf138d44ffebcea7bc0259bec"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.980/nuon_linux_arm64"
    sha256 "fae4a5b00aa76028c945044fc0ca3ee0451987c700775a226a67c986cc64b683"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.980/nuon-lsp_darwin_amd64"
      sha256 "2cdaba386cda2f8c54e207098d7e4d92875109bfbf36006481645384a3ddefb2"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.980/nuon-lsp_darwin_arm64"
      sha256 "ccdc9eeaf30e615ee0e5b937dbb849c3c183e0675a458c8a335ea3097c6e1f49"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.980/nuon-lsp_linux_amd64"
      sha256 "bb895702d9b5313ef6197738bfa18e5bb5aa725242031ab684e31c875be19ad8"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.980/nuon-lsp_linux_arm"
      sha256 "f35e046a77fb89077ba9b8a77a96267552200101d6508223cb2beb8193812545"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.980/nuon-lsp_linux_arm64"
      sha256 "198e9512fd2ddadc846a2e8d91c90612e5cfdb9c2bb8a5c570112379160b491a"
    end
  end

  def install
    # Determine CLI binary filename based on platform
    if OS.mac? && Hardware::CPU.intel?
      cli_filename = "nuon_darwin_amd64"
      lsp_filename = "nuon-lsp_darwin_amd64"
    elsif OS.mac? && Hardware::CPU.arm?
      cli_filename = "nuon_darwin_arm64"
      lsp_filename = "nuon-lsp_darwin_arm64"
    elsif OS.linux? && Hardware::CPU.intel?
      cli_filename = "nuon_linux_amd64"
      lsp_filename = "nuon-lsp_linux_amd64"
    elsif OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      cli_filename = "nuon_linux_arm"
      lsp_filename = "nuon-lsp_linux_arm"
    elsif OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      cli_filename = "nuon_linux_arm64"
      lsp_filename = "nuon-lsp_linux_arm64"
    end

    # Install CLI binary
    bin.install cli_filename => "nuon"

    # Install LSP binary from resource
    resource("lsp").stage do
      bin.install lsp_filename => "nuon-lsp"
    end
  end

  test do
    system "#{bin}/nuon", "version"
    system "#{bin}/nuon-lsp", "--help"
  end
end

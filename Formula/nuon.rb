class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.979"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.979/nuon_darwin_amd64"
    sha256 "877ddbd68b73a3983b91498c82178b6d9b2f6c0b5b086f5aeecf4c9f221a9ab1"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.979/nuon_darwin_arm64"
    sha256 "bc7e7c82dd7f0b8604bca6da04bbc2c49411361efb516a670027ad69a3d91bf8"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.979/nuon_linux_amd64"
    sha256 "bd4a05dd58916996952604e96398b89b2580d615e1d8ac11843f11034f4b4a4f"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.979/nuon_linux_arm"
    sha256 "e902c6e89f298f7c0db34db2a3ed4a93b943bb78819ccd81535f4a7c65ac2537"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.979/nuon_linux_arm64"
    sha256 "1e1a3643c453961a0ea7f78b39a0b2e1eedacba1452a8d3da871ddf9ebb5b391"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.979/nuon-lsp_darwin_amd64"
      sha256 "2cdaba386cda2f8c54e207098d7e4d92875109bfbf36006481645384a3ddefb2"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.979/nuon-lsp_darwin_arm64"
      sha256 "ccdc9eeaf30e615ee0e5b937dbb849c3c183e0675a458c8a335ea3097c6e1f49"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.979/nuon-lsp_linux_amd64"
      sha256 "bb895702d9b5313ef6197738bfa18e5bb5aa725242031ab684e31c875be19ad8"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.979/nuon-lsp_linux_arm"
      sha256 "f35e046a77fb89077ba9b8a77a96267552200101d6508223cb2beb8193812545"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.979/nuon-lsp_linux_arm64"
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

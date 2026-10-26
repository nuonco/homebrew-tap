class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1264"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1264/nuon_darwin_amd64"
    sha256 "deaba2686b4e37a3648ccb77f097f82131cad7b1d6f90c27c2e3a2e1952f45bf"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1264/nuon_darwin_arm64"
    sha256 "16e1d4d7d361b21c0352ad9c916f83c90be818cca0f123cd369306e0ec495390"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1264/nuon_linux_amd64"
    sha256 "b7afb33813d1b125674cb406681e5a5663b1b1cf66a84105d4d4e77d0a60c36b"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1264/nuon_linux_arm"
    sha256 "92c8f7d70357eb8545d9e68289b115e5f810d091d1a9d2cd1a0b4324f84f9689"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1264/nuon_linux_arm64"
    sha256 "1f637c025420066708d853843ef13735668b1ae49dbdcc042b398f30ee8b1d64"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1264/nuon-lsp_darwin_amd64"
      sha256 "aaad09c40081324a618f47316471b5b693c33d7a8bfe7c7de2daaf1c10a8e3a3"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1264/nuon-lsp_darwin_arm64"
      sha256 "df217e57e6af59941a41a0ec3004973312eea65b8d2d1f386debd15f096318c6"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1264/nuon-lsp_linux_amd64"
      sha256 "bc3c049bc66f651d2dcdb4c2c717f3e844d6b7bdfcc6765f1fbced00f9f982ce"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1264/nuon-lsp_linux_arm"
      sha256 "65aa6c3372d4f638f7cdb4660c84dd5712e5d90789818fee5e78b5c5bfb92d56"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1264/nuon-lsp_linux_arm64"
      sha256 "04981a74ce982f7388a8156f6a3abf4237eeabc2dc2c4cffbbb54f284ca7ff02"
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

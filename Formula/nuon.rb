class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.810"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.810/nuon_darwin_amd64"
    sha256 "a7157337eb08b3209808f42f756940cb624f92fca4f65f5577d1b60e68798e98"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.810/nuon_darwin_arm64"
    sha256 "fc50443ea715090dfd828617dcb92c017240088ad032954f6cb1e4ea11e9ccc3"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.810/nuon_linux_amd64"
    sha256 "6852354608ed4ccaf3beada8f9872aad4d956184a3b476bfb9f41ac366908ce7"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.810/nuon_linux_arm"
    sha256 "433e71dfa7eed7ac1ed9f5d889f2e7e2e3bf47e9370fffa187155478f66baec4"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.810/nuon_linux_arm64"
    sha256 "bd12dd48f7ef6a7b1d57506038118db78893e1635b41272d773be8c55e482de1"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.810/nuon-lsp_darwin_amd64"
      sha256 "345a270b2a72fa56e636e4d4eb727c5aceb059e22cbde3ad4116e1149ff6b34c"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.810/nuon-lsp_darwin_arm64"
      sha256 "5daef6c226d0cda5ceecf72591437848050b71c78b7dd3d037a1355d0d60109b"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.810/nuon-lsp_linux_amd64"
      sha256 "8a1403bc7607be5fbe0c47e6a27f7fa10c92dbff1cf03f095ac1708e2a9eb228"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.810/nuon-lsp_linux_arm"
      sha256 "eef230d493c99e737b7870a7c39da7fd12add166551bf7cc272293dc286a6f6f"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.810/nuon-lsp_linux_arm64"
      sha256 "571d193843ae4f33899e0bec3ab38d956e51a242153e2c442bca87d0f9b0414b"
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

class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.938"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.938/nuon_darwin_amd64"
    sha256 "390040cd68dd25653adee33ffc0ba9732c73cc5eb5837b7d8f21d8dcbb4953b3"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.938/nuon_darwin_arm64"
    sha256 "d018da7215fec7f5188aaf297b0ea52ffde6b0ad3eb5f7ae9e4d5b1e7c37e5aa"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.938/nuon_linux_amd64"
    sha256 "c315e37aff17b799aa6dd57f6b04f08223c1c679091ab719af236eab7128b943"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.938/nuon_linux_arm"
    sha256 "d2190a8bc19dd00efdd1832bb2b29f735e34c5708d0e0b0c0ba62d58566f5c63"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.938/nuon_linux_arm64"
    sha256 "f9f4a836a6c49cc6a17ef4b2fcf1f396320ccc32da8cceef2a0f5ac88a88fd3d"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.938/nuon-lsp_darwin_amd64"
      sha256 "d2e34c26829320571db4c09464b2665fa5a3529b064f102c3669369e895ed84c"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.938/nuon-lsp_darwin_arm64"
      sha256 "47fb9de4d7949b669994401bbbf5a1a76b68a15f02bc62e6841814a3003333d8"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.938/nuon-lsp_linux_amd64"
      sha256 "65ab9528ae09053eb0b233d9acfa6fd256d86696a9b8cb14f641ecedec9d711f"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.938/nuon-lsp_linux_arm"
      sha256 "a586a46dff1fcad22d8a6a91ab81ac9e9c958b76fd74cc3ab797e85c6dc597bf"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.938/nuon-lsp_linux_arm64"
      sha256 "7198b48323fc2735505e2660bb90c6f23c64e7decc9a1ff23693793bcaf60146"
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

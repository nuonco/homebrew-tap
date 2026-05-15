class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.939"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.939/nuon_darwin_amd64"
    sha256 "6a1c5016e9a1233e573d6c9b34336df0fa6db7152065669ae68d9c09f4140461"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.939/nuon_darwin_arm64"
    sha256 "fbc52d5450f95c271a441593c3ce2510664f3072b4e29c60454239322f76ec59"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.939/nuon_linux_amd64"
    sha256 "20f69c198e4cd6e11ee95ea82d69c186a17f892880758d6464da265a6dcab448"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.939/nuon_linux_arm"
    sha256 "d9f33dae65a33248656a8600b08fdbdb9496629a8b9aaf820290c1dcd7863864"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.939/nuon_linux_arm64"
    sha256 "cf3457f57c922dd29d5fce515cc34c2579bb6afa438a8ffbc9bd7dca3fddca09"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.939/nuon-lsp_darwin_amd64"
      sha256 "d2e34c26829320571db4c09464b2665fa5a3529b064f102c3669369e895ed84c"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.939/nuon-lsp_darwin_arm64"
      sha256 "47fb9de4d7949b669994401bbbf5a1a76b68a15f02bc62e6841814a3003333d8"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.939/nuon-lsp_linux_amd64"
      sha256 "65ab9528ae09053eb0b233d9acfa6fd256d86696a9b8cb14f641ecedec9d711f"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.939/nuon-lsp_linux_arm"
      sha256 "a586a46dff1fcad22d8a6a91ab81ac9e9c958b76fd74cc3ab797e85c6dc597bf"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.939/nuon-lsp_linux_arm64"
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

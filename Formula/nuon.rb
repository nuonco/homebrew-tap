class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.943"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.943/nuon_darwin_amd64"
    sha256 "87460e619926776bdbf9588c1d94a19a8293f18253cd844d96dd6fd7f5c1d3a6"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.943/nuon_darwin_arm64"
    sha256 "15999c6098c007919ec80eac609672ae0854d627b8045744f63c91f61020781c"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.943/nuon_linux_amd64"
    sha256 "2f65edf815541e7293d3c8cf17f10327f11ab729e6a87089d0fed2cc413b4794"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.943/nuon_linux_arm"
    sha256 "a881386be77a027d98a37bc8e4d91b8f2ff0159b2dd702147cf153f0cabf3677"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.943/nuon_linux_arm64"
    sha256 "cd5e246f2652b2d65d56abdde7dc36c460ce1c7f9578c4815026ecd6b6db08a5"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.943/nuon-lsp_darwin_amd64"
      sha256 "d2e34c26829320571db4c09464b2665fa5a3529b064f102c3669369e895ed84c"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.943/nuon-lsp_darwin_arm64"
      sha256 "47fb9de4d7949b669994401bbbf5a1a76b68a15f02bc62e6841814a3003333d8"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.943/nuon-lsp_linux_amd64"
      sha256 "65ab9528ae09053eb0b233d9acfa6fd256d86696a9b8cb14f641ecedec9d711f"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.943/nuon-lsp_linux_arm"
      sha256 "a586a46dff1fcad22d8a6a91ab81ac9e9c958b76fd74cc3ab797e85c6dc597bf"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.943/nuon-lsp_linux_arm64"
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

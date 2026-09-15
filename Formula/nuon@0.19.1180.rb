class NuonAT0191180 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1180"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1180/nuon_darwin_amd64"
    sha256 "6d4513fb3c27b104a3702462764dafb0a63e8b4f3bcef1ef847abdd0c1bb617a"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1180/nuon_darwin_arm64"
    sha256 "ebde8a80b78daf8bb6c6d8bd0d526cda2a0dfcb66fc2bebe58d8f4d57f193e2d"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1180/nuon_linux_amd64"
    sha256 "ea858d130f396c9f36325a91f89ab83de87c4d80807b94d1ce1b25955a135f48"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1180/nuon_linux_arm"
    sha256 "c7c71b4f246592e1a77ebd938da45d93cb39b666e8e67e3cf63befcdb0af6a97"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1180/nuon_linux_arm64"
    sha256 "e19d7bf5cd5d5d7de1d0724b061a78b44a00cbccda2016b571a090282a4004e7"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1180/nuon-lsp_darwin_amd64"
      sha256 "32cca7831c3c0139b04ed1e296bf26a48c30edb4f340ad3b0c270e6658de43ab"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1180/nuon-lsp_darwin_arm64"
      sha256 "0ffffd91eefd21198434f8371bc09e8319ab1bf09cac5277fa66facd662ee7aa"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1180/nuon-lsp_linux_amd64"
      sha256 "9c4f553b6ec84396a1a9f6b23aea0c476288001001470cf94d289e2f8d5a0112"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1180/nuon-lsp_linux_arm"
      sha256 "2c0dc46bb573474ca722c35f1b4a15f8666162713c2acdbc80a92e6358d03c16"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1180/nuon-lsp_linux_arm64"
      sha256 "0af4b634c4cf8eaeb765dd522985bf249a91e91686604d66c84691cc45b99321"
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

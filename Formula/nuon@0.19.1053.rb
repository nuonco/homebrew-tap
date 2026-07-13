class NuonAT0191053 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1053"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1053/nuon_darwin_amd64"
    sha256 "2365ec7eee00fa4788b6e1c709dc6feb1258396f815c40ac9e76d79cbd16abb8"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1053/nuon_darwin_arm64"
    sha256 "080394acb9e4e27f82d983c683582ef42e600f4b1da5297bebd116c4510a7697"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1053/nuon_linux_amd64"
    sha256 "d47f025b3aa1611c22275069b7b3b10578689d9573d598dbc0f4ec2f2bca8eb5"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1053/nuon_linux_arm"
    sha256 "1a99cf8269922d5ee0469797f6756d63ecf2389a3b96ca94fec6dbd427b00acc"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1053/nuon_linux_arm64"
    sha256 "87058d1b250b18cafb295be3a6f91d8a68c323d3dfa291eead8517804bb27e1f"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1053/nuon-lsp_darwin_amd64"
      sha256 "aebb1adb69efcfb8198ff6fbb12b9b936ec1f3fd4d346436220756449f8f027f"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1053/nuon-lsp_darwin_arm64"
      sha256 "430c7c8a18898a75347c84a5db3e8929bdcd68d92a800cca8940a2c8ba0fbc84"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1053/nuon-lsp_linux_amd64"
      sha256 "0dc1f4e93dbb89aef2cdefa3340eced596a653c7034ec9c1634450c39830b5f5"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1053/nuon-lsp_linux_arm"
      sha256 "f8b4360c42dc7eeb5de12f1dfade5fbcad0ee8f5a4ad8630f959480be82496a4"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1053/nuon-lsp_linux_arm64"
      sha256 "9388d87ae8038538c58f4c61b6362ca66a6aac4f16d950379e55fc63a97309f3"
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

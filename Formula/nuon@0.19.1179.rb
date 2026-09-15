class NuonAT0191179 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1179"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1179/nuon_darwin_amd64"
    sha256 "b4b505c08067b860b84175b8e976a33f6682e15c36b74547da968d3244fe32d1"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1179/nuon_darwin_arm64"
    sha256 "3eed0eb78a605ca0ba684503bca6cdfb2afe5db10dd4138c089235d465fa7f70"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1179/nuon_linux_amd64"
    sha256 "f5249799f3d07ff146a5e72e01f852dcdf98e01194248ce420657afa55d6f863"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1179/nuon_linux_arm"
    sha256 "79626fbc1d3e2ea050f2f2822815a93f8a42d8d7b8f86e465bde06a778e4b25b"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1179/nuon_linux_arm64"
    sha256 "ddf870e516060bfdc2569bc8da38e064b03c8fbe006851ceda4560080369e616"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1179/nuon-lsp_darwin_amd64"
      sha256 "32cca7831c3c0139b04ed1e296bf26a48c30edb4f340ad3b0c270e6658de43ab"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1179/nuon-lsp_darwin_arm64"
      sha256 "0ffffd91eefd21198434f8371bc09e8319ab1bf09cac5277fa66facd662ee7aa"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1179/nuon-lsp_linux_amd64"
      sha256 "9c4f553b6ec84396a1a9f6b23aea0c476288001001470cf94d289e2f8d5a0112"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1179/nuon-lsp_linux_arm"
      sha256 "2c0dc46bb573474ca722c35f1b4a15f8666162713c2acdbc80a92e6358d03c16"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1179/nuon-lsp_linux_arm64"
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

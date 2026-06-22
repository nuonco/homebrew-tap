class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1013"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1013/nuon_darwin_amd64"
    sha256 "f91e30d4d40cd977bb2ac8314a1020e60c70fdff32b1846483b9d1c32c520b9b"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1013/nuon_darwin_arm64"
    sha256 "a7df12fac8e36a1d00f8e4382566fd0e10937c538aef800db17c8015f29d6f47"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1013/nuon_linux_amd64"
    sha256 "2c6cf54b41ab8fd3b86672d5a0265ecdf1f287fffc15ca58550e53ed8dc8bfe5"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1013/nuon_linux_arm"
    sha256 "d7c73670c50d0fea59216d4747b26d4d7ec5824d17348dc0f44ea5af19635ef6"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1013/nuon_linux_arm64"
    sha256 "56ea416c9e829cd53ac2d1e39b4fbdc2d8e230137c4c1ea43a538ea0e2ff6b12"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1013/nuon-lsp_darwin_amd64"
      sha256 "f6c174f620feccfd4cbd4439126bac743448b74f7b86693bbc2347e571d2d20d"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1013/nuon-lsp_darwin_arm64"
      sha256 "fc1928ae04f03b8dae58107f2f1345e22760cff807e5191b2fca47534d4c8605"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1013/nuon-lsp_linux_amd64"
      sha256 "120e8ee821007f3b2794f87aec15cd5f91f149a8471a3cafee062ac8b6bed2a6"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1013/nuon-lsp_linux_arm"
      sha256 "f3c91fef0f6f1082d42ef1ac884fe3faa5f100a43d7822e6005b19c232149040"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1013/nuon-lsp_linux_arm64"
      sha256 "15cc2f80028acc78517a86884d76599cc983ca1ca82afee076fa4df4013ae5a6"
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

class NuonAT0191109 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1109"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1109/nuon_darwin_amd64"
    sha256 "131a8559da32151fff6a15b21356d597c3d6f2a3359bf11f91747b8bfb49e696"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1109/nuon_darwin_arm64"
    sha256 "77b4d261585910f414f1d1f6bc1219f7f2c8fcfcc33a13f2b0ccc6b836ccf151"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1109/nuon_linux_amd64"
    sha256 "9b6d8ea4ebde37f13efc92eaf320b8479481cdf8e3ab8401523c496e943366ad"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1109/nuon_linux_arm"
    sha256 "1f748789d79f9cfb1d50709e8ad11215e3d13a16c308f20176e6a95d2caed9a3"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1109/nuon_linux_arm64"
    sha256 "cccecbab98921266030ed74b3ec0d7f685c8fa3fd819ab6b67c0487a9d61557b"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1109/nuon-lsp_darwin_amd64"
      sha256 "04116cc1a29802509a1663393c5f2e6a2ebd9976fc4a061a7e1c31869e4d7fc0"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1109/nuon-lsp_darwin_arm64"
      sha256 "ff1891bd1bca67517167321be6eeb64427fa76308f97e6435d296d4df5678a0b"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1109/nuon-lsp_linux_amd64"
      sha256 "45dacb2965c6157db424357cf5e1f45c760a9e10788ba56f56704acea1ce4c6a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1109/nuon-lsp_linux_arm"
      sha256 "5bae5025253b64626022a2da3b99842a38ae603f041b78d9e70f3c2e873f5493"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1109/nuon-lsp_linux_arm64"
      sha256 "51056a1bc2040e229c6749fc5f8de1dff331c5c31b46c698ca0c3b9e7c017ccc"
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

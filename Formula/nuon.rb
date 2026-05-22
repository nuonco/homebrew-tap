class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.964"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.964/nuon_darwin_amd64"
    sha256 "cdf1ecbec349d56a20cd84fb8e5c524c07fde7068bafd3944c88d0730cf442e4"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.964/nuon_darwin_arm64"
    sha256 "5f430619654dfa10cf390917da879bb1ac95fdcb93b83d28f2e842da2800d942"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.964/nuon_linux_amd64"
    sha256 "8d71dc3d0d3d7639b88d262a296249428f846d0f3d97ea26dbbadc1e6870ab9f"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.964/nuon_linux_arm"
    sha256 "96ea4e7f425a247f0a1dff2e39a38bad23ca345cfa597cd5b4d9b1ed33bccef7"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.964/nuon_linux_arm64"
    sha256 "5612401b264a6ae4cf4c8ed2bf4d7449ca83f8496716b58b8d6d689fc7b7392e"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.964/nuon-lsp_darwin_amd64"
      sha256 "7f963c3b338f479d3427d3853b163f1fe673c6cffd1085772018a5a1a43a1df2"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.964/nuon-lsp_darwin_arm64"
      sha256 "60474fdec024e93aff03212da0a06f6c1dd98590ed0ac488974b7e9b059d7ab8"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.964/nuon-lsp_linux_amd64"
      sha256 "7f3d372b5263e115470928a5b6dcf0dc53a67a620d01cef0182cb882baef4366"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.964/nuon-lsp_linux_arm"
      sha256 "e3c53eceb40f3c00599b980c41db1d1678897fc2d6b8c6a3882a9adfa852b36a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.964/nuon-lsp_linux_arm64"
      sha256 "1be72727407644ef827c89e5fca9b99541aa06825bda83b33dd0da3c021aceea"
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

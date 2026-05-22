class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.965"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.965/nuon_darwin_amd64"
    sha256 "534b12c9ccc788bc7cf114bb516a8b301defeaea2dc5472d0d4a6d033c9b8576"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.965/nuon_darwin_arm64"
    sha256 "fb3078211876850dfea2ba43a383b84a34437d6c3ab45aaa340b5ec69c58fdb0"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.965/nuon_linux_amd64"
    sha256 "2f3482ad6f5e602801534c28a7e2df9b451ad58955d9167c68d65a87db41c93b"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.965/nuon_linux_arm"
    sha256 "0b6eeaa28a1d86cb749828f768a539e09c184efe8641d1d329051f1085a6b496"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.965/nuon_linux_arm64"
    sha256 "00372417561e38b255521c9a6ac05111ffa1513f20227e71bc88d38298b47866"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.965/nuon-lsp_darwin_amd64"
      sha256 "7f963c3b338f479d3427d3853b163f1fe673c6cffd1085772018a5a1a43a1df2"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.965/nuon-lsp_darwin_arm64"
      sha256 "60474fdec024e93aff03212da0a06f6c1dd98590ed0ac488974b7e9b059d7ab8"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.965/nuon-lsp_linux_amd64"
      sha256 "7f3d372b5263e115470928a5b6dcf0dc53a67a620d01cef0182cb882baef4366"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.965/nuon-lsp_linux_arm"
      sha256 "e3c53eceb40f3c00599b980c41db1d1678897fc2d6b8c6a3882a9adfa852b36a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.965/nuon-lsp_linux_arm64"
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

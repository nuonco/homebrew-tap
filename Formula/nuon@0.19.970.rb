class NuonAT019970 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.970"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.970/nuon_darwin_amd64"
    sha256 "e5e0cc4c7192afa0326e1b04a8cfb0234a8f2d4bf447b0011cb2837b47bd27ef"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.970/nuon_darwin_arm64"
    sha256 "dbccdc0d07b916f78e83baf8092c831374d3db5ca0a9b0655334b5d00351216e"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.970/nuon_linux_amd64"
    sha256 "0b9bd97ea0ccbe6ce63605d53635d5f22048e66f9a9070d6155036b009132556"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.970/nuon_linux_arm"
    sha256 "4a646d23fbea1f3b8bd80bac44332483466d5ce262fa4d19f8db3bd83118afe9"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.970/nuon_linux_arm64"
    sha256 "b4a347321353e3003c5770c97ef1007606b21e6ae2b7c462128ec09cd753b97e"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.970/nuon-lsp_darwin_amd64"
      sha256 "7f963c3b338f479d3427d3853b163f1fe673c6cffd1085772018a5a1a43a1df2"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.970/nuon-lsp_darwin_arm64"
      sha256 "60474fdec024e93aff03212da0a06f6c1dd98590ed0ac488974b7e9b059d7ab8"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.970/nuon-lsp_linux_amd64"
      sha256 "7f3d372b5263e115470928a5b6dcf0dc53a67a620d01cef0182cb882baef4366"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.970/nuon-lsp_linux_arm"
      sha256 "e3c53eceb40f3c00599b980c41db1d1678897fc2d6b8c6a3882a9adfa852b36a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.970/nuon-lsp_linux_arm64"
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

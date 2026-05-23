class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.968"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.968/nuon_darwin_amd64"
    sha256 "30a4468fc73e10169e2d31c245cbb47aadd2275e8bfdd8ec196ee5ceb91b1df1"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.968/nuon_darwin_arm64"
    sha256 "96707115de890716557dbde937ac6dd7cb0bcba67d1fa5d14b04f37df6360c77"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.968/nuon_linux_amd64"
    sha256 "5d2100bae3b7296514c0096cc20e4a609b2f70db487fb006b6923487e8908b10"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.968/nuon_linux_arm"
    sha256 "dd3b2aa37924ca688080994511974b2b0393c564f3656241c86e2ac44793c5b6"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.968/nuon_linux_arm64"
    sha256 "b4d8cd742df63621d61ac375437107a83c3fdb9e50d76802d77e8f556e303959"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.968/nuon-lsp_darwin_amd64"
      sha256 "7f963c3b338f479d3427d3853b163f1fe673c6cffd1085772018a5a1a43a1df2"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.968/nuon-lsp_darwin_arm64"
      sha256 "60474fdec024e93aff03212da0a06f6c1dd98590ed0ac488974b7e9b059d7ab8"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.968/nuon-lsp_linux_amd64"
      sha256 "7f3d372b5263e115470928a5b6dcf0dc53a67a620d01cef0182cb882baef4366"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.968/nuon-lsp_linux_arm"
      sha256 "e3c53eceb40f3c00599b980c41db1d1678897fc2d6b8c6a3882a9adfa852b36a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.968/nuon-lsp_linux_arm64"
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

class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.969"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.969/nuon_darwin_amd64"
    sha256 "e0e678948c45c1b8240efbb2273d2228088332befb37aee67e63883d84853806"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.969/nuon_darwin_arm64"
    sha256 "220262f71ffb8ec2625cc87addf36e78d4dd3c9ec0799294849d6c8460ab02c4"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.969/nuon_linux_amd64"
    sha256 "8717b71cf9fb084a34c48b0ddb1d5c7b5f1d8ca3a58fb32d718a6b75c2eaf13c"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.969/nuon_linux_arm"
    sha256 "c7243a9d762a60c554a1be2e133e44e8d0b73564f79dee4351b9f35663c53c54"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.969/nuon_linux_arm64"
    sha256 "d5f2353bed68df142265e6389c30e08ae94a14b16d32ae5cc3a01841b3246de0"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.969/nuon-lsp_darwin_amd64"
      sha256 "7f963c3b338f479d3427d3853b163f1fe673c6cffd1085772018a5a1a43a1df2"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.969/nuon-lsp_darwin_arm64"
      sha256 "60474fdec024e93aff03212da0a06f6c1dd98590ed0ac488974b7e9b059d7ab8"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.969/nuon-lsp_linux_amd64"
      sha256 "7f3d372b5263e115470928a5b6dcf0dc53a67a620d01cef0182cb882baef4366"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.969/nuon-lsp_linux_arm"
      sha256 "e3c53eceb40f3c00599b980c41db1d1678897fc2d6b8c6a3882a9adfa852b36a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.969/nuon-lsp_linux_arm64"
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

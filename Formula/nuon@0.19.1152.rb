class NuonAT0191152 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1152"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1152/nuon_darwin_amd64"
    sha256 "1ed07bbec2d026518564c43172f83757ad3939ee1b6319454e1365900eb0bfb1"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1152/nuon_darwin_arm64"
    sha256 "a3f89169d88995a6d68065dd9c3379db08b074f7e6fe746d209d1f1f4f3bc411"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1152/nuon_linux_amd64"
    sha256 "840541e03758f55176fd3c53a7e313cf93a06b23fe01a4b9c65f4c7fc55401c9"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1152/nuon_linux_arm"
    sha256 "3708c493abe95cbb3b62a9f4000e89c9e78199f21454180b9981d09739dcc4b1"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1152/nuon_linux_arm64"
    sha256 "c117a4040b677ca9810bdcdcbef969a310fbce5a666d243d19a73e6c6a20ac49"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1152/nuon-lsp_darwin_amd64"
      sha256 "4ba5002fec47f4d1ca62479b26b41da27de72194373bda1823e2c0aa6f2f461c"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1152/nuon-lsp_darwin_arm64"
      sha256 "fd92433f94af393e279d8a8c0809c4fd35329b8aea359747c39ae9b61ee71ea6"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1152/nuon-lsp_linux_amd64"
      sha256 "bce506fbe50975c49956ed47fee80c762dd911268152591fd5ff42fc08c36269"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1152/nuon-lsp_linux_arm"
      sha256 "1eec140e7f6c583592904ab70ce4f34a835e77c74ea592de60bd4f5f712d4202"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1152/nuon-lsp_linux_arm64"
      sha256 "0e61c44538230d68a56fad4584501cd0f531e9c99868cc812e18934dc518e81f"
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

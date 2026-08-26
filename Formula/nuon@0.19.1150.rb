class NuonAT0191150 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1150"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1150/nuon_darwin_amd64"
    sha256 "5959c6b8c2c9613cd9e9f9ac1ee99472f8f99e586bc82686d116b87f8c746350"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1150/nuon_darwin_arm64"
    sha256 "70f21c90c97b436befd545a0eadddce8b645866e1067e8a342811e002cdab283"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1150/nuon_linux_amd64"
    sha256 "74f083f07455de6010f2a4e4fe804bbaffef3a065b66dd2b477b1325d282b390"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1150/nuon_linux_arm"
    sha256 "10990b789efa246514000ad4195619eda2d14ed161d8d8e1f561ee9329ed98ab"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1150/nuon_linux_arm64"
    sha256 "dda7de72209cb0c0965f59a7330fe56d6efa3a322da64328316a6f67c18b61da"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1150/nuon-lsp_darwin_amd64"
      sha256 "4ba5002fec47f4d1ca62479b26b41da27de72194373bda1823e2c0aa6f2f461c"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1150/nuon-lsp_darwin_arm64"
      sha256 "fd92433f94af393e279d8a8c0809c4fd35329b8aea359747c39ae9b61ee71ea6"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1150/nuon-lsp_linux_amd64"
      sha256 "bce506fbe50975c49956ed47fee80c762dd911268152591fd5ff42fc08c36269"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1150/nuon-lsp_linux_arm"
      sha256 "1eec140e7f6c583592904ab70ce4f34a835e77c74ea592de60bd4f5f712d4202"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1150/nuon-lsp_linux_arm64"
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

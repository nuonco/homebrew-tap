class NuonAT0191151 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1151"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1151/nuon_darwin_amd64"
    sha256 "d777c921fd8be66ccc64d8cb2e7ad75e7ba17f56c306f3396070d03461cf0ce7"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1151/nuon_darwin_arm64"
    sha256 "8ece07b595100f0ee399c35d367047122f91efb1929c61ea629607720a6a350c"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1151/nuon_linux_amd64"
    sha256 "343c917e3b861f6e1b6e37b4c728468e291b240e3edea8cbb1bf4079eb625c37"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1151/nuon_linux_arm"
    sha256 "0552a2daed5c5818f5d91345c3a4bd46bf1b6d69b0098f9d25ede59a45f93065"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1151/nuon_linux_arm64"
    sha256 "a90955f8df63aa657e0a9df610775191d58c3b104118d22017e2b10dbfaae17a"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1151/nuon-lsp_darwin_amd64"
      sha256 "4ba5002fec47f4d1ca62479b26b41da27de72194373bda1823e2c0aa6f2f461c"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1151/nuon-lsp_darwin_arm64"
      sha256 "fd92433f94af393e279d8a8c0809c4fd35329b8aea359747c39ae9b61ee71ea6"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1151/nuon-lsp_linux_amd64"
      sha256 "bce506fbe50975c49956ed47fee80c762dd911268152591fd5ff42fc08c36269"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1151/nuon-lsp_linux_arm"
      sha256 "1eec140e7f6c583592904ab70ce4f34a835e77c74ea592de60bd4f5f712d4202"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1151/nuon-lsp_linux_arm64"
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

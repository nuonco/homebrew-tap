class NuonAT0191283 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1283"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1283/nuon_darwin_amd64"
    sha256 "2b6a287abfd968252646d8e0ef3151cadebe013c232962be396556a0d162ba6b"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1283/nuon_darwin_arm64"
    sha256 "2ddb91a27c1b5309d91c258a73c3af68ea873c3237514acc289eb5de5b5067c8"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1283/nuon_linux_amd64"
    sha256 "e8e460222be984b712951af72114aaa12f7f6ff6bfde4cf74b2c2716335b75fb"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1283/nuon_linux_arm"
    sha256 "01e27ab0b2d4a6551ed822d834aa9ee1a43d26de9e3cadd6e8f549d852349bcd"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1283/nuon_linux_arm64"
    sha256 "27618e9b3e3d017e3684154f1c4ff155c79a113113fa908772a6b20b16ada319"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1283/nuon-lsp_darwin_amd64"
      sha256 "6424fe5d4e4c0f16929d0eef5f213719003eaea1df9770898a8719689223f761"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1283/nuon-lsp_darwin_arm64"
      sha256 "16cd7302b6edb04b80db23e242f32a9110acc27078b3fc305ebfee9de908f0ee"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1283/nuon-lsp_linux_amd64"
      sha256 "01b18eac9a39cbaef2dd27eacf8942fac7237eb8b991f7372a631b682d270f7c"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1283/nuon-lsp_linux_arm"
      sha256 "ab9b31f0dab0320c0d669ed9792505f369f141cb9eddc6731004c1003e6bacbf"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1283/nuon-lsp_linux_arm64"
      sha256 "ac563bd30c78d61b13f2bc8d522590c61c715d14ae460a4eeeac3941e71fd27f"
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

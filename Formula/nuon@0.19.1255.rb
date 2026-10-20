class NuonAT0191255 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1255"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1255/nuon_darwin_amd64"
    sha256 "14e02389d26f6d2512c5553222ea134f244ba5f5fb8955b41483246a4fbb78b7"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1255/nuon_darwin_arm64"
    sha256 "c5d35a74cf5366959c1bfe6fc35e058f7e53221e0fda3e7a97a437452733c1ea"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1255/nuon_linux_amd64"
    sha256 "d2b27bd85c079bdfae3640cb5e2ae032f2d5fc1d7982a37a7d919554f8441d70"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1255/nuon_linux_arm"
    sha256 "534becfefaecb5c764bea820eb19cf681c4cbac64cd3852a981dc84f41b6e5f1"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1255/nuon_linux_arm64"
    sha256 "ade86a3b3e47666af7914284bfece08a9c21d985479ef0e7f6ce335c7651bba4"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1255/nuon-lsp_darwin_amd64"
      sha256 "a03b44e574bb530ef037475235b28eefdb3ecd14b6222f3cc89cc113fc388f4c"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1255/nuon-lsp_darwin_arm64"
      sha256 "5e1377fc1730d4a9b34b0e28984590355d4030085236f799a71e42cfb2dc2e22"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1255/nuon-lsp_linux_amd64"
      sha256 "4a9889f5efafdc4c618f9a67005c1a8fabbc49ad8369974722f8a16c3c37171e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1255/nuon-lsp_linux_arm"
      sha256 "a9321c72181aba6d7f73a43af7a7d21728f7c5d073f438ea58e0ab80e12ec7d4"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1255/nuon-lsp_linux_arm64"
      sha256 "b7897917bae7e51e71205ffe1e0a1456fd423746df3157c98064b96a2007da48"
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

class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1253"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1253/nuon_darwin_amd64"
    sha256 "f891ed791b445826d8ab037b68a0e6c723e15598fe0e6079955152ad0113f80a"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1253/nuon_darwin_arm64"
    sha256 "e2c4eab9de916510f2add291b77ea6b87baab743da23d40bef8ab3153cdad3c4"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1253/nuon_linux_amd64"
    sha256 "256136c99696ba6d3e09f581dfecbd51cc982b1823989936d59aa6a8cd6d65a3"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1253/nuon_linux_arm"
    sha256 "7e5e6facc0fd5991fdde921de69df17f807115e5d33bed2062b0b58f0440ab04"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1253/nuon_linux_arm64"
    sha256 "0626b361c46c7599a7d3664dc049c488c1120e510d6b9f8df37a6cbafe1a3e34"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1253/nuon-lsp_darwin_amd64"
      sha256 "a03b44e574bb530ef037475235b28eefdb3ecd14b6222f3cc89cc113fc388f4c"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1253/nuon-lsp_darwin_arm64"
      sha256 "5e1377fc1730d4a9b34b0e28984590355d4030085236f799a71e42cfb2dc2e22"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1253/nuon-lsp_linux_amd64"
      sha256 "4a9889f5efafdc4c618f9a67005c1a8fabbc49ad8369974722f8a16c3c37171e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1253/nuon-lsp_linux_arm"
      sha256 "a9321c72181aba6d7f73a43af7a7d21728f7c5d073f438ea58e0ab80e12ec7d4"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1253/nuon-lsp_linux_arm64"
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

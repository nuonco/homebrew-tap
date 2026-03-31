class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.862"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.862/nuon_darwin_amd64"
    sha256 "92b79f1db4f3e57296fef99bb6c466bd8fb374554ae7c9b832ae75924c8aef41"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.862/nuon_darwin_arm64"
    sha256 "3d712525498b604ab1153a9823710e46c1eb91e2b0bd9e8830029c160f2e5dc3"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.862/nuon_linux_amd64"
    sha256 "57aa7dd97d8aee3c8f19e0bad33001fc508fb003f1d012891d53640982d01bff"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.862/nuon_linux_arm"
    sha256 "5c12df7ba9981f2b4ec42af2a516ebd7764d571d88c6add4035ba90534402a97"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.862/nuon_linux_arm64"
    sha256 "8dc774313e41a912207a352972d8c6960b9774707b74205b072e5d60a41a4d7f"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.862/nuon-lsp_darwin_amd64"
      sha256 "543ca21320be4a73bc18133522b360e2415040ec4feeebb22603b2784100c6a7"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.862/nuon-lsp_darwin_arm64"
      sha256 "b3b36e44f5b4c388a40903d020b3a469658ea08691280321e4d871a8106ce73e"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.862/nuon-lsp_linux_amd64"
      sha256 "dd43337cfbad0bc91da22ab09d2501a7148cebf23d342fecd9ee135ca3b48aad"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.862/nuon-lsp_linux_arm"
      sha256 "4bfd9390d92b548ac60a062d44e710b5212baba16d08183be02093b4ada39e86"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.862/nuon-lsp_linux_arm64"
      sha256 "da3b5b6a66571dbb2ad39e6102de010ac7d21c276f06bf3e1e7b9200c08283ad"
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

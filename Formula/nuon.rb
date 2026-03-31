class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.864"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.864/nuon_darwin_amd64"
    sha256 "9b6bfe08f8a90008ac264c53ead5380c5713b45d64c9e6f502665bc3acf8a1d6"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.864/nuon_darwin_arm64"
    sha256 "e2884027d04119eb51224606593e522788b313ca9549f0e7a64bbe3d6a6c5604"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.864/nuon_linux_amd64"
    sha256 "b98e1a8402587f8440190dcdb0a9c656db0de2ab3b2c054a8762996b2de0ded7"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.864/nuon_linux_arm"
    sha256 "aa930e9ea559399ac76c5f3ebe625003407565708bfaaed45cca67e7d7c77287"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.864/nuon_linux_arm64"
    sha256 "a8276614019b29f2852cd77191904be361230951a9e6f1be45686e68bae64b86"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.864/nuon-lsp_darwin_amd64"
      sha256 "543ca21320be4a73bc18133522b360e2415040ec4feeebb22603b2784100c6a7"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.864/nuon-lsp_darwin_arm64"
      sha256 "b3b36e44f5b4c388a40903d020b3a469658ea08691280321e4d871a8106ce73e"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.864/nuon-lsp_linux_amd64"
      sha256 "dd43337cfbad0bc91da22ab09d2501a7148cebf23d342fecd9ee135ca3b48aad"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.864/nuon-lsp_linux_arm"
      sha256 "4bfd9390d92b548ac60a062d44e710b5212baba16d08183be02093b4ada39e86"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.864/nuon-lsp_linux_arm64"
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

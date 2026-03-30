class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.861"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.861/nuon_darwin_amd64"
    sha256 "b58c6f8d1136c4e0cba85663969e22edfde966af568ea909a5f4dabfff80b17d"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.861/nuon_darwin_arm64"
    sha256 "da67759161eb5e837b0463919b668b367b0367f95ee7f706de4887e5ac741030"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.861/nuon_linux_amd64"
    sha256 "209b32ce4d6502084409653eb77830053ed6306a05bd11b4302c7442a76968ea"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.861/nuon_linux_arm"
    sha256 "1d806588d195dc0dd4e35d58aaa2169aa40d2a9cfee448adfbebf014b10380c4"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.861/nuon_linux_arm64"
    sha256 "36fffdeb3f42d8ebe49034c7838bac12a7a558d61e75e242d5eb24d3f4b992da"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.861/nuon-lsp_darwin_amd64"
      sha256 "543ca21320be4a73bc18133522b360e2415040ec4feeebb22603b2784100c6a7"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.861/nuon-lsp_darwin_arm64"
      sha256 "b3b36e44f5b4c388a40903d020b3a469658ea08691280321e4d871a8106ce73e"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.861/nuon-lsp_linux_amd64"
      sha256 "dd43337cfbad0bc91da22ab09d2501a7148cebf23d342fecd9ee135ca3b48aad"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.861/nuon-lsp_linux_arm"
      sha256 "4bfd9390d92b548ac60a062d44e710b5212baba16d08183be02093b4ada39e86"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.861/nuon-lsp_linux_arm64"
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

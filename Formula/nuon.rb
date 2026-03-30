class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.860"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.860/nuon_darwin_amd64"
    sha256 "7ea2d85352db3da03f7a0db97ebb07e2f054cf1e30039a98e30136baa9096e90"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.860/nuon_darwin_arm64"
    sha256 "b75d70e1a04ffa1f6375a800ea60ed7a249094c5c550e8a0ef8f8a1343eaf2d2"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.860/nuon_linux_amd64"
    sha256 "87e4b1049433c7cb67296a745f25800f64e93c3fc12f794e30009479dafcf016"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.860/nuon_linux_arm"
    sha256 "3b51265912bd7b6fc3c501f5cb609e540b19f28458b1d2c1cdf2be0acbc477e1"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.860/nuon_linux_arm64"
    sha256 "b8b92187e05c4e1e292651d9b2ab7d3f10da20002d58a2dec1b7292b6d7264c1"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.860/nuon-lsp_darwin_amd64"
      sha256 "543ca21320be4a73bc18133522b360e2415040ec4feeebb22603b2784100c6a7"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.860/nuon-lsp_darwin_arm64"
      sha256 "b3b36e44f5b4c388a40903d020b3a469658ea08691280321e4d871a8106ce73e"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.860/nuon-lsp_linux_amd64"
      sha256 "dd43337cfbad0bc91da22ab09d2501a7148cebf23d342fecd9ee135ca3b48aad"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.860/nuon-lsp_linux_arm"
      sha256 "4bfd9390d92b548ac60a062d44e710b5212baba16d08183be02093b4ada39e86"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.860/nuon-lsp_linux_arm64"
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

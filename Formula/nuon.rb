class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.866"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.866/nuon_darwin_amd64"
    sha256 "ecd9639dd57722a3e59c7eb71a47f34bd8598c34394940cb36910193f5690175"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.866/nuon_darwin_arm64"
    sha256 "036f21af9b224ad6d0af6e7cdf4db53512fad6c2b6cdfcbe508f32d28f9b93fb"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.866/nuon_linux_amd64"
    sha256 "bab6190a36f205dfebf818d3c2cdb44d95a5ab22baed69476ebdfcaadde86d09"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.866/nuon_linux_arm"
    sha256 "38d5636933e73b8026d0bd299bfb4b7abd47a2fbde923838e9f88174a1b27cba"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.866/nuon_linux_arm64"
    sha256 "0737a1af77014e4fc44e51ce7bdcabff9ea65c274f829678b775d6a70404a64a"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.866/nuon-lsp_darwin_amd64"
      sha256 "543ca21320be4a73bc18133522b360e2415040ec4feeebb22603b2784100c6a7"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.866/nuon-lsp_darwin_arm64"
      sha256 "b3b36e44f5b4c388a40903d020b3a469658ea08691280321e4d871a8106ce73e"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.866/nuon-lsp_linux_amd64"
      sha256 "dd43337cfbad0bc91da22ab09d2501a7148cebf23d342fecd9ee135ca3b48aad"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.866/nuon-lsp_linux_arm"
      sha256 "4bfd9390d92b548ac60a062d44e710b5212baba16d08183be02093b4ada39e86"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.866/nuon-lsp_linux_arm64"
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

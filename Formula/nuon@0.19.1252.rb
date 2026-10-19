class NuonAT0191252 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1252"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1252/nuon_darwin_amd64"
    sha256 "1130983a840d67c4a4468ff5e576ba7e00b07eef74c602c67b87d580625bdfdc"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1252/nuon_darwin_arm64"
    sha256 "b05aa477d4cabbf66f335b2ef202f004debff20cff23f14a874a5e144cdd6bc0"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1252/nuon_linux_amd64"
    sha256 "f7b7805f40e9151780e75874c0f937f527e3e7b83c3fcf68946a7f8d55317de2"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1252/nuon_linux_arm"
    sha256 "8f6dd47886e1585969c1e33c929e96ce73e5bbd6dc465927b17d2c53b356263e"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1252/nuon_linux_arm64"
    sha256 "eafda20adcd8209fd72c32be1785066a9744311786a6045c25f979932d90596c"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1252/nuon-lsp_darwin_amd64"
      sha256 "a03b44e574bb530ef037475235b28eefdb3ecd14b6222f3cc89cc113fc388f4c"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1252/nuon-lsp_darwin_arm64"
      sha256 "5e1377fc1730d4a9b34b0e28984590355d4030085236f799a71e42cfb2dc2e22"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1252/nuon-lsp_linux_amd64"
      sha256 "4a9889f5efafdc4c618f9a67005c1a8fabbc49ad8369974722f8a16c3c37171e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1252/nuon-lsp_linux_arm"
      sha256 "a9321c72181aba6d7f73a43af7a7d21728f7c5d073f438ea58e0ab80e12ec7d4"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1252/nuon-lsp_linux_arm64"
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

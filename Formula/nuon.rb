class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.974"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.974/nuon_darwin_amd64"
    sha256 "d05ebe8cc3a2f2c62b36c999099eb6b4720f6732ebed2bf8d528ad1ab05fc3d8"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.974/nuon_darwin_arm64"
    sha256 "4ff54c486c1987440bb24d9b407919624593867607a7d7fc0dcd0b4cc5d5f0cb"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.974/nuon_linux_amd64"
    sha256 "4dfe63c7d992a6b99c75a1ec8395af7b62f6b01f74649a32c3be50e9d6c4c677"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.974/nuon_linux_arm"
    sha256 "b92e061305510069b2ab53d2d91a68c954b6d030e129a3b314966c79a62436a6"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.974/nuon_linux_arm64"
    sha256 "479c8ce5b77bb8d1e6cabb530b8d577266e64697243b19b4ee371410ffcb1dd8"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.974/nuon-lsp_darwin_amd64"
      sha256 "3a66f90b65d949bbc33ad2fb8c2322a7a06d0ee6637ded8eb2c05f31aa002d34"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.974/nuon-lsp_darwin_arm64"
      sha256 "bd0fca91309719bde276f620c4096d350715bd90a4ae0fd22a2bab92d3952369"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.974/nuon-lsp_linux_amd64"
      sha256 "55a21d854e409b9be1567856f3c00d1e39068263ef8b96d8a10a9ff03b539bf6"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.974/nuon-lsp_linux_arm"
      sha256 "6fff226a84d60156cd74fe6d53fae35d40c81beb1ac28ea4c7c5a1497e44dc1b"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.974/nuon-lsp_linux_arm64"
      sha256 "982743348b2e383aae71759837eb111908aa4b976141d843300ff60e6f23f560"
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

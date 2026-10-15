class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1245"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1245/nuon_darwin_amd64"
    sha256 "ebb587beefa9b177ee9d7750aba23d91534d4c897301fb49687969cb5c62f214"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1245/nuon_darwin_arm64"
    sha256 "f0413710cb030f18323920d4eac3a9d975d39baada93fbfa073beeed625f90fb"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1245/nuon_linux_amd64"
    sha256 "ef91bc290425ed8029ae29cea4f4ef4d0a40c36f467610975477b3b5d14f11cb"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1245/nuon_linux_arm"
    sha256 "cce25a8cdaf36daee77dedf08f477ce31844582b02d30775e4d795fb37d891ec"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1245/nuon_linux_arm64"
    sha256 "2208e13c431f7f2b3ca2be83b05d4ecbd13bb7139de88a1d3e1766bb1cccb8d9"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1245/nuon-lsp_darwin_amd64"
      sha256 "82a52c8bb665be702e0c8f8dba93edd872f1d0e2585394871d359e650621aaa5"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1245/nuon-lsp_darwin_arm64"
      sha256 "522db34e6652fd49a3dbe6857dd06e4bb6741552cc49122ea022779868005d8c"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1245/nuon-lsp_linux_amd64"
      sha256 "739297a4bfa6af55ba73c28a94e18a6cfaa083ecb1b062c01f6b872bbc6ce421"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1245/nuon-lsp_linux_arm"
      sha256 "4a5064279a52e5e8f09ee20564c48a2db399a0759c40e3840d10ae6306e21d16"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1245/nuon-lsp_linux_arm64"
      sha256 "fd606eb5d7bd8bb1243a7624b81d75adc1a015a61a09ffea68e7607a8db2b038"
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

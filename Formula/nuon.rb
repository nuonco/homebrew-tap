class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.870"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.870/nuon_darwin_amd64"
    sha256 "dbd96e2957b5a8c0e5399d3a0f0873783b301b1ce9de78a33e717dcda2e41a00"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.870/nuon_darwin_arm64"
    sha256 "2f98aa994be345583478ec06cf1cb02a977b9f5443dd518c88b4a6434235c600"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.870/nuon_linux_amd64"
    sha256 "bbfbd052a345917d4fc20c4913fdf83bea4d883e3795ea783ccf1315317bd5a4"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.870/nuon_linux_arm"
    sha256 "5c3fbaaebb62d7002320319ce2e63fe7f43467c79df632bdf23154aa6f2a41e1"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.870/nuon_linux_arm64"
    sha256 "9481f2aa77afce7bb581cf89b354a4e209fd79f989f7d404576d987b00d05cb4"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.870/nuon-lsp_darwin_amd64"
      sha256 "c2bd17af75502b8291b50c77eb0efffdcde245896241edbd1b0ad4d069f0333a"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.870/nuon-lsp_darwin_arm64"
      sha256 "f1ac87063bbf2d2a6c10b3257a87a1a770f52ca80d1bf976e6b53091d1d227bf"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.870/nuon-lsp_linux_amd64"
      sha256 "5cebdca4e315bb912addba0714c7f51f1ba488cb644a970c5cbf6b48543c86da"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.870/nuon-lsp_linux_arm"
      sha256 "5b42522098311e8382113b5fd959f9e6acdd96665cf3e3992b32907a2cfde4ef"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.870/nuon-lsp_linux_arm64"
      sha256 "5d3f4ccf63932cbc5db06c295fed784709a4215f1898e4d7fa4d8c0f1e15b93b"
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

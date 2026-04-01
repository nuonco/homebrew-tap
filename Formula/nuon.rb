class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.871"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.871/nuon_darwin_amd64"
    sha256 "49bf1b75b4276be8f7eabe6032cd1a2fc7e5a3e00bf3d13a20a3e787e0d59c67"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.871/nuon_darwin_arm64"
    sha256 "ce1f5843eab879cda03158e022277d491e74c6a462bf4f6da265a09339806638"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.871/nuon_linux_amd64"
    sha256 "6f63625fd4e15c317192859c9714df6fea32ed01b18c059421e349722534e2a2"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.871/nuon_linux_arm"
    sha256 "ee2ca84224eac0e96b19362a08699130f82c2e8c11c6e8e271296a0762b2991a"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.871/nuon_linux_arm64"
    sha256 "1888970f19c8aa6efcc652187c666a06cdd19b62029019252d38b01c2b1133c9"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.871/nuon-lsp_darwin_amd64"
      sha256 "c2bd17af75502b8291b50c77eb0efffdcde245896241edbd1b0ad4d069f0333a"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.871/nuon-lsp_darwin_arm64"
      sha256 "f1ac87063bbf2d2a6c10b3257a87a1a770f52ca80d1bf976e6b53091d1d227bf"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.871/nuon-lsp_linux_amd64"
      sha256 "5cebdca4e315bb912addba0714c7f51f1ba488cb644a970c5cbf6b48543c86da"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.871/nuon-lsp_linux_arm"
      sha256 "5b42522098311e8382113b5fd959f9e6acdd96665cf3e3992b32907a2cfde4ef"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.871/nuon-lsp_linux_arm64"
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

class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.800"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.800/nuon_darwin_amd64"
    sha256 "288620d4202f1cfe83986d4ff541f35784256e7b8f8912766d9b8fb11a796ec3"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.800/nuon_darwin_arm64"
    sha256 "d8cad3a95f60ba45d8ffc8d81468293efcf96dbfdfff3fb2e2fd0eac3b3a45bd"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.800/nuon_linux_amd64"
    sha256 "dc08249a1f2c1ceedb6aae5e13533d38aa7cbd932a068da8ae1cb12ec4391e3f"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.800/nuon_linux_arm"
    sha256 "967a6a0013dfa2810916a7ba7ce71e9c1f6cade4b776f96c86120cfca4f53297"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.800/nuon_linux_arm64"
    sha256 "1ce310c02807b3ad32b1fe009ed7f06fb0fe28ccc877e43165ffd0e3dca3e511"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.800/nuon-lsp_darwin_amd64"
      sha256 "3a6bcccf6f7b80bf3a1035e4fd5c875618afd25d8e22f7029d2a0cb69011212c"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.800/nuon-lsp_darwin_arm64"
      sha256 "80659897096dcb757867ce2c7aa974c9860529736a3d076c901605dc96928290"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.800/nuon-lsp_linux_amd64"
      sha256 "4bf24ba57c2c43d62a659eb6362f4228dfe4baa2bd1307ec34702cf0ff7ba940"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.800/nuon-lsp_linux_arm"
      sha256 "b20f6031ff062b21c1d3d9ad87ee32a0368b20393318f155b4227432aca4ba2a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.800/nuon-lsp_linux_arm64"
      sha256 "26c1d0febdee4be3302c1297f306d07b12f656655be65f9241922c0a4d211191"
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

class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.997"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.997/nuon_darwin_amd64"
    sha256 "514a75cb9f3a051081ca138be5923866424e2740e7656c38c5bbb960f90798a0"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.997/nuon_darwin_arm64"
    sha256 "ac48a513b3d2bd56b1e8f0e2570813547964b277cae3b28630e690e210cbe85c"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.997/nuon_linux_amd64"
    sha256 "1d7b4e982ddb6850f6608cf1a52fbe5d0b691e5db368cdaf28afe2b82cd02e26"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.997/nuon_linux_arm"
    sha256 "5c1b1c53ffd90ef4014c963445a5ba89c45f041c0db9c95767c0aa42574340c8"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.997/nuon_linux_arm64"
    sha256 "ae199ad73dd8a1d00e18a1abfb5f5f9e1b60530a97cd09c34dce6837619d5fad"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.997/nuon-lsp_darwin_amd64"
      sha256 "e770293eb0e8da8ed0c04f67f793a1ff28b3bbe203997fe9e4c733faa7136544"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.997/nuon-lsp_darwin_arm64"
      sha256 "cfef9a317718f99156268ef26c5ee36f84fe4cd39fe17aceac9b9d2a16d933fc"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.997/nuon-lsp_linux_amd64"
      sha256 "5f64ac3b72503d1e423158e799f59b0c6e2eda245b5e6ad0fc22c5fd60f72219"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.997/nuon-lsp_linux_arm"
      sha256 "592ebaf3c97cc2f1301fff01d9ec3fa15fbe944ad780851b3003ced3c7eb0c74"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.997/nuon-lsp_linux_arm64"
      sha256 "d9f8e92ae106ca0b88cf92c4ca51457d4b393bb5ac70b2f77664abefa11fd6d9"
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

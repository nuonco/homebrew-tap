class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.987"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.987/nuon_darwin_amd64"
    sha256 "4392a191b691121c891de7c8d81fb270052973405642f82b5a99f47e4f68e609"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.987/nuon_darwin_arm64"
    sha256 "c63e9d8a1b0af085798a0bd6e9ee54f67728183a369d99e02acf521a2e7b2e3d"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.987/nuon_linux_amd64"
    sha256 "c2354b162a89f79b107c10d07446a91e21ade343ecdd78aaab1f841ca89a9f0a"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.987/nuon_linux_arm"
    sha256 "d02c2ed5427cee44cdf2f9b1260e0ef4e525a7e8863b1699523139da4a85a959"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.987/nuon_linux_arm64"
    sha256 "7e59379ae714a07429ffdab7b92294317d6a227b7ee5866bba2d8377c15b493c"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.987/nuon-lsp_darwin_amd64"
      sha256 "d7ffc965d347c1f930e2736fe2754fa1d51ebd8eae6d5c9b33b969fe9157e43d"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.987/nuon-lsp_darwin_arm64"
      sha256 "19b8fc0394f56455a66df8fa0b4d178788a94f09fd71d7af8f4416f4b32c049c"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.987/nuon-lsp_linux_amd64"
      sha256 "2708a6afca748cd50a70015c030be3d39c0e663fe437d0679f06a4a7bc771993"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.987/nuon-lsp_linux_arm"
      sha256 "bfc96d3a33b41aef08f25555d1fb3cc5bcc5e13c5b966499fae573d827336c9e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.987/nuon-lsp_linux_arm64"
      sha256 "de857c19537d375b5df374c2297f9b54c9e79f978128d2039d9399cd032cc7bc"
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

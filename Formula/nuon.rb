class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.972"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.972/nuon_darwin_amd64"
    sha256 "8ab7c6d04ba6bc62f681a4776efc58f23e43480a89b55fdb088fa3d407174814"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.972/nuon_darwin_arm64"
    sha256 "dbd80705462458e288a9c6ea22b308e8451e08462a24de172835d7bc6b170ad1"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.972/nuon_linux_amd64"
    sha256 "8e5e712abcac02881309c8c9070e85beed6b5b92bf582047a8c97fac89d49eaa"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.972/nuon_linux_arm"
    sha256 "18123674ea547414c0fb14b891b5538cc691ed941b75422288c50bcdc7749a36"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.972/nuon_linux_arm64"
    sha256 "54a0ccf9daeaeaf09e66bb711124716c0bf04bab06899714f4708f787fb17fe3"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.972/nuon-lsp_darwin_amd64"
      sha256 "3c6a3810863713014e864f77d8e65cc9277f3cabe85dc2c68ed08bbad2b15493"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.972/nuon-lsp_darwin_arm64"
      sha256 "7f95d0b2c2b7f4495d961ba6b06b8e6858a5214a0429b9f5a789c7ddd1d87869"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.972/nuon-lsp_linux_amd64"
      sha256 "d47a18e8b45b19c174e0a3204dc8abd90b1ab0d4831c72f07eb545d935094d64"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.972/nuon-lsp_linux_arm"
      sha256 "271c06957e9aea4763772fe668abce691ebbefea561bfa2488589385d920df55"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.972/nuon-lsp_linux_arm64"
      sha256 "34236c01f99dbabc0d936d72023664c6d0a7cd157f53ce56d165ca4581bb61c8"
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

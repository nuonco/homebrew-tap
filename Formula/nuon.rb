class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1024"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1024/nuon_darwin_amd64"
    sha256 "b7411ca212ff08995847e2cfe8132188b88e8d60fd8ee822bec99b73e80a2090"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1024/nuon_darwin_arm64"
    sha256 "e8dafef631ed88770c3ae8463a8395d296a1fbe92292de03379856fdb871dd83"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1024/nuon_linux_amd64"
    sha256 "ad05a607ce7bc9d23ec8ecd35e766e7df2b142bdf0a0a72b93335f0650d6053d"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1024/nuon_linux_arm"
    sha256 "d998cb4e54569cff4dd3249e706d8d37a3fbcf3e977d4be3e1b371c6be99d882"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1024/nuon_linux_arm64"
    sha256 "696c1bdcc54e0e22f8bb6833f24a8401aa1a6cd860875332d8c5de7b475a3317"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1024/nuon-lsp_darwin_amd64"
      sha256 "49839fac18369a3ef07f90041d02ca5d690e2b29848c9b57438c7de81101a23d"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1024/nuon-lsp_darwin_arm64"
      sha256 "6a88fcfe93cb04300068b02e5e55fda3bc559c3d26fa2e2778ea30813b137e88"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1024/nuon-lsp_linux_amd64"
      sha256 "457fcb07b4a03d34199656f6631007e87cf0d876375623d8364e79fb971590dd"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1024/nuon-lsp_linux_arm"
      sha256 "455725786a5faa067381ee80894553284e858a2680e4041c6f7faea8dcaf10f2"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1024/nuon-lsp_linux_arm64"
      sha256 "175da0cf4b959932fd02e5617aab47e4a19f7e01cba4f2de947cccf2dd07fbce"
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

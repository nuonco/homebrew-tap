class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1265"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1265/nuon_darwin_amd64"
    sha256 "d8e9761e2280d11caee3b38610ee949f4178ba536ed6f2aa0073f44f3060d119"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1265/nuon_darwin_arm64"
    sha256 "4220489a52571e131892000234804320514d3eb5bab2b162220baac96dcd4e83"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1265/nuon_linux_amd64"
    sha256 "07e62365f75fe001683d96285516214be65f1f9afeabddbf3a45e71d39c116b1"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1265/nuon_linux_arm"
    sha256 "4a3969de4baf2f40fb41a19ab4ab0cb008fc6b23b1fc0d10ff1a5e6768d7a246"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1265/nuon_linux_arm64"
    sha256 "ccd574954c368b53d58d7499ebd03bd1a1ca8eac2cd49179483c7dc806805bfa"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1265/nuon-lsp_darwin_amd64"
      sha256 "aaad09c40081324a618f47316471b5b693c33d7a8bfe7c7de2daaf1c10a8e3a3"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1265/nuon-lsp_darwin_arm64"
      sha256 "df217e57e6af59941a41a0ec3004973312eea65b8d2d1f386debd15f096318c6"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1265/nuon-lsp_linux_amd64"
      sha256 "bc3c049bc66f651d2dcdb4c2c717f3e844d6b7bdfcc6765f1fbced00f9f982ce"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1265/nuon-lsp_linux_arm"
      sha256 "65aa6c3372d4f638f7cdb4660c84dd5712e5d90789818fee5e78b5c5bfb92d56"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1265/nuon-lsp_linux_arm64"
      sha256 "04981a74ce982f7388a8156f6a3abf4237eeabc2dc2c4cffbbb54f284ca7ff02"
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

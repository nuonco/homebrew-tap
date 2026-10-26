class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1263"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1263/nuon_darwin_amd64"
    sha256 "28f598629d5782f642426f00ade5b82b32a5f83b022621a6cb8c7aba5286fb59"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1263/nuon_darwin_arm64"
    sha256 "dfdbe8145dd52798393defb382f12928b5ccf878b304e611d55271246ac28b04"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1263/nuon_linux_amd64"
    sha256 "1ec0f8620b6d8ac618e7829858c105b5edd26debee6201e068f4b58f6559435c"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1263/nuon_linux_arm"
    sha256 "d136e9985a0b7821567a2454d92ecb0bc85c4000884932023be13dcc94eddd24"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1263/nuon_linux_arm64"
    sha256 "9c5326e66b25d032ee50c04e66b84598233c4bcd86a971309e11b31713c2d4b4"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1263/nuon-lsp_darwin_amd64"
      sha256 "aaad09c40081324a618f47316471b5b693c33d7a8bfe7c7de2daaf1c10a8e3a3"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1263/nuon-lsp_darwin_arm64"
      sha256 "df217e57e6af59941a41a0ec3004973312eea65b8d2d1f386debd15f096318c6"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1263/nuon-lsp_linux_amd64"
      sha256 "bc3c049bc66f651d2dcdb4c2c717f3e844d6b7bdfcc6765f1fbced00f9f982ce"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1263/nuon-lsp_linux_arm"
      sha256 "65aa6c3372d4f638f7cdb4660c84dd5712e5d90789818fee5e78b5c5bfb92d56"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1263/nuon-lsp_linux_arm64"
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

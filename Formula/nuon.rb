class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.716"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.716/nuon_darwin_amd64"
    sha256 "e534e01daa0d90379a53daae277355494e7ee67c9867ddb588d28d2b042f05ca"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.716/nuon_darwin_arm64"
    sha256 "cc62190af8f41b7b457fb6043fcc4e3d9825e64f42e4899df79644f3212caa71"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.716/nuon_linux_amd64"
    sha256 "e658b625af625cd63914a663f6afd9e002dd7f36a886cee85be88fa4f219c6d6"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.716/nuon_linux_arm"
    sha256 "78e65a94a9827ae45a41998278bee6fc18ddfb36fe4faac4dc44c9089264b397"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.716/nuon_linux_arm64"
    sha256 "a4c7548c2153ad3a4d750e03e89f361615ffbbe415956c4fbf0bd284b23ec197"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.716/nuon-lsp_darwin_amd64"
      sha256 "91e75bfe30d23c9b6f539e93aaeed980fd4f63f184185168ec497479636c00db"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.716/nuon-lsp_darwin_arm64"
      sha256 "95bc44fd4f10f3338d2eab8ae5d945a3b8198364761e95d441043d0c12626641"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.716/nuon-lsp_linux_amd64"
      sha256 "7771d8cf000d7e83eb14151adf6d21249b9c686ded95551a82c439500c71f36d"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.716/nuon-lsp_linux_arm"
      sha256 "c9daee0ed2a3d0d36ff4ba45fa8939e8d720651f969afda9ecd7d9d02c396d8a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.716/nuon-lsp_linux_arm64"
      sha256 "acd24f0427873e377853804f8cd303c2c24eef5ccb212b454fa8e9976dc066eb"
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

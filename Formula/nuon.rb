class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.717"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.717/nuon_darwin_amd64"
    sha256 "3a818dec4234b22eeee5f00fe8107e8b22ad2b104e44147215f4584a543107e2"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.717/nuon_darwin_arm64"
    sha256 "5c52f593429c9a46348b9d94e83a83e1cd08e08f9785b64d4b66c520b0182922"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.717/nuon_linux_amd64"
    sha256 "451bda2d701af404345bed4c1ed041d017f10f52bed319761672711eb5453dba"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.717/nuon_linux_arm"
    sha256 "d2f3d1b2be4eb06bc85c5efef1c8e1dc4c1cb82f1a43871795dfd155fdd0a53d"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.717/nuon_linux_arm64"
    sha256 "1de29f14debbd41ea83e8410826d13b2ab0fd4612f814d5fab45e7cba0676004"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.717/nuon-lsp_darwin_amd64"
      sha256 "91e75bfe30d23c9b6f539e93aaeed980fd4f63f184185168ec497479636c00db"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.717/nuon-lsp_darwin_arm64"
      sha256 "95bc44fd4f10f3338d2eab8ae5d945a3b8198364761e95d441043d0c12626641"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.717/nuon-lsp_linux_amd64"
      sha256 "7771d8cf000d7e83eb14151adf6d21249b9c686ded95551a82c439500c71f36d"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.717/nuon-lsp_linux_arm"
      sha256 "c9daee0ed2a3d0d36ff4ba45fa8939e8d720651f969afda9ecd7d9d02c396d8a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.717/nuon-lsp_linux_arm64"
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

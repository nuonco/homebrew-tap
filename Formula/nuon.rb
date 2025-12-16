class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.719"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.719/nuon_darwin_amd64"
    sha256 "c256a9f09c175c19e16c30106eb3d6455286ed3a22f14be7bb85e8598746ce11"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.719/nuon_darwin_arm64"
    sha256 "5e4e5df8f745918f5e62135811f36f858023501ce7df4923dbd819e062263eab"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.719/nuon_linux_amd64"
    sha256 "9b1559f7ef89e2dcdb7b78e06f5cdd5eda2fbac084655dc5e2300dc75d3b4989"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.719/nuon_linux_arm"
    sha256 "0ec5ac6c5058a1276e11a35556dd45965e21f5378b07a3b1abe9b9b1031d0241"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.719/nuon_linux_arm64"
    sha256 "b2a82010eb54807fcf3a9985bca73159612a3edcb28d109473524ae9461601c3"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.719/nuon-lsp_darwin_amd64"
      sha256 "91e75bfe30d23c9b6f539e93aaeed980fd4f63f184185168ec497479636c00db"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.719/nuon-lsp_darwin_arm64"
      sha256 "95bc44fd4f10f3338d2eab8ae5d945a3b8198364761e95d441043d0c12626641"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.719/nuon-lsp_linux_amd64"
      sha256 "7771d8cf000d7e83eb14151adf6d21249b9c686ded95551a82c439500c71f36d"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.719/nuon-lsp_linux_arm"
      sha256 "c9daee0ed2a3d0d36ff4ba45fa8939e8d720651f969afda9ecd7d9d02c396d8a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.719/nuon-lsp_linux_arm64"
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

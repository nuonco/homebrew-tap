class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.715"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.715/nuon_darwin_amd64"
    sha256 "9b314562ea579abba5207624c81b29548999c00bcba1e28e2ce976583f9f6494"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.715/nuon_darwin_arm64"
    sha256 "4514e66d05fa0852ebf5c0090bece7ba8e21c64cf5ba0b1c9789ab757dcc75e5"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.715/nuon_linux_amd64"
    sha256 "3f17cdac6516e198072526a6da5f3b8c1f8e8d16da98effd63e7d2ad8ea5a7d9"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.715/nuon_linux_arm"
    sha256 "a8bc9a28eb5f8f54603dc3b7890971d0fee6c77ea32099fcb89b75f200738583"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.715/nuon_linux_arm64"
    sha256 "7633e711c2daa30133c1ee29b94a302b87af72e89c128b794596e38d01cb0863"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.715/nuon-lsp_darwin_amd64"
      sha256 "91e75bfe30d23c9b6f539e93aaeed980fd4f63f184185168ec497479636c00db"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.715/nuon-lsp_darwin_arm64"
      sha256 "95bc44fd4f10f3338d2eab8ae5d945a3b8198364761e95d441043d0c12626641"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.715/nuon-lsp_linux_amd64"
      sha256 "7771d8cf000d7e83eb14151adf6d21249b9c686ded95551a82c439500c71f36d"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.715/nuon-lsp_linux_arm"
      sha256 "c9daee0ed2a3d0d36ff4ba45fa8939e8d720651f969afda9ecd7d9d02c396d8a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.715/nuon-lsp_linux_arm64"
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

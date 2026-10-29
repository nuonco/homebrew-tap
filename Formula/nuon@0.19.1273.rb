class NuonAT0191273 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1273"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1273/nuon_darwin_amd64"
    sha256 "968794bca4ecf4f16663f6261868ec6ff6216055a2fe64c6ff6530ecc2d607f9"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1273/nuon_darwin_arm64"
    sha256 "f5d5f5dd4accb034f8ac6a6235267df121c476516bc24dc95eee8821df0e8844"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1273/nuon_linux_amd64"
    sha256 "6319ea932e4efa0eab36e61a0117ada58cfb394686c202cb7c29b240be954bfc"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1273/nuon_linux_arm"
    sha256 "e5d74713341752afbadd28878a07b9b104c7b7909a2f49b5f38286327cf0d271"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1273/nuon_linux_arm64"
    sha256 "9a07af93b59cc25365f157fd0a4b817914fa609870889f61f22a82a27fe8b701"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1273/nuon-lsp_darwin_amd64"
      sha256 "eec9f06de5597d78b90b63ae3ca5cb9882ce51a17ce1c1511c141fe9c66e2b1a"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1273/nuon-lsp_darwin_arm64"
      sha256 "213c8752356094619e74b043933444944b2f5896383c02e2e774c6ee7e8fb089"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1273/nuon-lsp_linux_amd64"
      sha256 "8c1f17aebd96071b9002129e1baef3aaab1ebd8c683a48c0290e48d17f01deb7"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1273/nuon-lsp_linux_arm"
      sha256 "f0ba8c88977a95772808849f3e49f6a5484c96680ddee6081464dc764965e003"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1273/nuon-lsp_linux_arm64"
      sha256 "da44296540039db139e4fa0aa25c180e2dc94d9976b4813735951f403918ead7"
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

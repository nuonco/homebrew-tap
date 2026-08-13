class NuonAT0191123 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1123"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1123/nuon_darwin_amd64"
    sha256 "46d4f87f8f186b29247d78f2549a97e44f9b8f86d0c5746a30504d7cf7baa1de"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1123/nuon_darwin_arm64"
    sha256 "78b68231bee5b0ee46fe01d74839d74de2fa3ff54c8afd0199efcefe40d2e4a1"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1123/nuon_linux_amd64"
    sha256 "3c3331e89ee69dbddda32cfed5181bc81bfe226609d3e5b090e9c9a328cc5e4f"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1123/nuon_linux_arm"
    sha256 "7f30dadcb3f7ef716fc4f6c68bc5336119acc4fa9d4882478b5ac72f027b0a42"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1123/nuon_linux_arm64"
    sha256 "b8ad2c5b9cca0802ee7397423356ba11dff321a6b0c434913c8e74db1a917d96"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1123/nuon-lsp_darwin_amd64"
      sha256 "5b658d7e4b518745362d2c2c95fd1bbfb61fd586e486ccbb2e35ef94715a602c"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1123/nuon-lsp_darwin_arm64"
      sha256 "c6d1f8118026f4726fbd91ffd8b1b8bb3a4f3fcf2261282286cbbc864709ac5d"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1123/nuon-lsp_linux_amd64"
      sha256 "a4ae7e73d111c87f83ca39a24acb6148797ff3ab807a5cf8c5eeadc026efcd10"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1123/nuon-lsp_linux_arm"
      sha256 "09f400ac524a6050dc452ac3f46256e0b945d386fa3e4514ab6513283b79e3b5"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1123/nuon-lsp_linux_arm64"
      sha256 "4a3c5d116ad7dd2aae9e4a88011997da958345635801bc76b0425850043da9db"
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

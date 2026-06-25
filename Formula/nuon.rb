class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1015"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1015/nuon_darwin_amd64"
    sha256 "ab85dc719300f9e78daca76b24a46bcca633b1cce4d3023d86ae6231a3d9efa7"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1015/nuon_darwin_arm64"
    sha256 "ee970fb60056e25c59fee23ac4f3a0a1f6c97f860cb6c0a8697a54dad3204193"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1015/nuon_linux_amd64"
    sha256 "ee2170026c7cda157570e422ff93d520a7b2b9677fa257fb4605f1d19ca59052"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1015/nuon_linux_arm"
    sha256 "00d6bc37fb2c65f25f6fd0eb32f160e2b4ba9858158294b23d61f44b5f04ac76"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1015/nuon_linux_arm64"
    sha256 "39500c177440b03ce4b18f277cefaedb33906de7af6d0c499b22778409e7e68a"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1015/nuon-lsp_darwin_amd64"
      sha256 "54319fd79b8be5f0a922bd6db6fc6041f043662c795543ceb9d7e367a016142b"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1015/nuon-lsp_darwin_arm64"
      sha256 "b9f61723f9d7f1712d2d364535fd8978972f2b55d63087a20b963e9140e2ad80"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1015/nuon-lsp_linux_amd64"
      sha256 "47376e0bc160604e86775363ff38886318a775243ba5633f11658bbfb9d5d118"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1015/nuon-lsp_linux_arm"
      sha256 "fde03453b3f68f580d0af11143198b802f41106e29bbac6a98f6c612e6a87aea"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1015/nuon-lsp_linux_arm64"
      sha256 "91d6357879edb06ef920b3daa9d7aa9272d9e535f0daa5ddd071dbc3d197f5c9"
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

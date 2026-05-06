class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.917"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.917/nuon_darwin_amd64"
    sha256 "c7ca0c0bac4b72372e308de967907155c182a9f0d7e823e60480f4896c05f62e"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.917/nuon_darwin_arm64"
    sha256 "c2bdcd71f152a2385b3ecbeff7b384e1ca298070c3601b021474005b1edf7b40"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.917/nuon_linux_amd64"
    sha256 "e3e1ca9aeb2e7d63b37dbe6c0a0d929a403ed614ed7077aad2f88ab87b86fd30"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.917/nuon_linux_arm"
    sha256 "ba49f854c94e85e74c9c17a71b4489abaa780cf60d596726c72a680176c1dc2c"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.917/nuon_linux_arm64"
    sha256 "7b7ce891ad569981709ee38f9b32224948cc8e00a4faf9954c1cc2768559fd23"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.917/nuon-lsp_darwin_amd64"
      sha256 "96f5a1b5bfd0be56ab405f81e5e51deb18d4fd25f1fcce57eccfb57a86aa45ec"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.917/nuon-lsp_darwin_arm64"
      sha256 "875fe60f059da22a93b972fec19190f9b9e3ccf3461b3785a7e2561193884bc5"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.917/nuon-lsp_linux_amd64"
      sha256 "12492580c289feba322bf1561ed097a31c49fbd228475336c33ae8a11c392cfd"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.917/nuon-lsp_linux_arm"
      sha256 "857d89d09c056e14dbe8fd44c399719824bac9d32af403e3237cb15576e9f3fa"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.917/nuon-lsp_linux_arm64"
      sha256 "8b4e01930005fe89bcdab23f7f38438d0a8415fd5b7c92767a99778d8ddf8bb1"
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

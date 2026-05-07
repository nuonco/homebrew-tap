class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.921"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.921/nuon_darwin_amd64"
    sha256 "792bd4e1838777c916ea166057be826f32e463aaa2860b8341936869673d7ec6"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.921/nuon_darwin_arm64"
    sha256 "3e2ff166558ed568b3b357b2f5188a0d10fc76d42acacf116212f87d9780c768"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.921/nuon_linux_amd64"
    sha256 "f0210099d51704c1b0c63c5310a6b7f29fb6bbb663a271909515394c99ec59e6"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.921/nuon_linux_arm"
    sha256 "14d9cdf6690b328781db5267037af8fd102169b7db7a69d02f8e14d4d338631f"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.921/nuon_linux_arm64"
    sha256 "434e136fb55df2be9ac7a2c2c8de27a2bf486d1efe58477ad5a855a8d3541814"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.921/nuon-lsp_darwin_amd64"
      sha256 "96f5a1b5bfd0be56ab405f81e5e51deb18d4fd25f1fcce57eccfb57a86aa45ec"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.921/nuon-lsp_darwin_arm64"
      sha256 "875fe60f059da22a93b972fec19190f9b9e3ccf3461b3785a7e2561193884bc5"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.921/nuon-lsp_linux_amd64"
      sha256 "12492580c289feba322bf1561ed097a31c49fbd228475336c33ae8a11c392cfd"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.921/nuon-lsp_linux_arm"
      sha256 "857d89d09c056e14dbe8fd44c399719824bac9d32af403e3237cb15576e9f3fa"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.921/nuon-lsp_linux_arm64"
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

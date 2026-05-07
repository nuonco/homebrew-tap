class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.922"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.922/nuon_darwin_amd64"
    sha256 "56460fec89053ac47e5ad2c6f42d9a29c7084cbb3abbc64f3f7be9e6d3e5371e"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.922/nuon_darwin_arm64"
    sha256 "4429f5e1641575a2019b9ac1bf360dce641ab2ae36a74a5574baff8180ab96c2"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.922/nuon_linux_amd64"
    sha256 "995a7ec6286120253896a14ec9beb15277edf12db718acd99700119b01e65de5"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.922/nuon_linux_arm"
    sha256 "19cec4e83d7091845b76312369dc1995ce19d5afa05080a7e525604d38b3be0b"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.922/nuon_linux_arm64"
    sha256 "ee3ba84e7f764b91e6652ac0575429850754f20ee02e77b2851a8c4fd90e29db"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.922/nuon-lsp_darwin_amd64"
      sha256 "96f5a1b5bfd0be56ab405f81e5e51deb18d4fd25f1fcce57eccfb57a86aa45ec"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.922/nuon-lsp_darwin_arm64"
      sha256 "875fe60f059da22a93b972fec19190f9b9e3ccf3461b3785a7e2561193884bc5"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.922/nuon-lsp_linux_amd64"
      sha256 "12492580c289feba322bf1561ed097a31c49fbd228475336c33ae8a11c392cfd"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.922/nuon-lsp_linux_arm"
      sha256 "857d89d09c056e14dbe8fd44c399719824bac9d32af403e3237cb15576e9f3fa"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.922/nuon-lsp_linux_arm64"
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

class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.920"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.920/nuon_darwin_amd64"
    sha256 "a291a31589d8505d4b0525e3ec6c113c7d0c4b62662d2cb5fc5cb8af5031bd30"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.920/nuon_darwin_arm64"
    sha256 "006b076b8939740db81440d107fe2f93af55c7a156dc796a2cba09c2581d29f1"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.920/nuon_linux_amd64"
    sha256 "92b4fed6877156cc478119fc9a159facbe48c2041502588b674b27e0233a1af1"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.920/nuon_linux_arm"
    sha256 "7c6012295d3c9394b1301e52c66b8c3668917b69d3b0e28553bf8ef3c2da214f"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.920/nuon_linux_arm64"
    sha256 "ea3f1d3610845645379e657d29f3714cfd0cf53881d45bdfda53dab3d724936b"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.920/nuon-lsp_darwin_amd64"
      sha256 "96f5a1b5bfd0be56ab405f81e5e51deb18d4fd25f1fcce57eccfb57a86aa45ec"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.920/nuon-lsp_darwin_arm64"
      sha256 "875fe60f059da22a93b972fec19190f9b9e3ccf3461b3785a7e2561193884bc5"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.920/nuon-lsp_linux_amd64"
      sha256 "12492580c289feba322bf1561ed097a31c49fbd228475336c33ae8a11c392cfd"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.920/nuon-lsp_linux_arm"
      sha256 "857d89d09c056e14dbe8fd44c399719824bac9d32af403e3237cb15576e9f3fa"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.920/nuon-lsp_linux_arm64"
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

class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.919"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.919/nuon_darwin_amd64"
    sha256 "a635bdc92f66234d5eb8c9452e4d34ffb065e027afa01c0851c36d4948ab3c48"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.919/nuon_darwin_arm64"
    sha256 "287c9a8eafed02d96cc0a9d19eac91baf5851de9592ead7696d36971b505b6e2"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.919/nuon_linux_amd64"
    sha256 "6a9b17285ce1bdc977c157e3db3d2e36989e590ad357cef3b94dbf3492d385ac"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.919/nuon_linux_arm"
    sha256 "ccc0a1afd47b6a68f9f2640ff195b905c29490b20ba46cfc49cebf61ca6406bf"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.919/nuon_linux_arm64"
    sha256 "b5ab3d4fd40c3448ffbc0c1447b50e9b2f4aa204e1b67b6c9bc24c403a3010e6"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.919/nuon-lsp_darwin_amd64"
      sha256 "96f5a1b5bfd0be56ab405f81e5e51deb18d4fd25f1fcce57eccfb57a86aa45ec"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.919/nuon-lsp_darwin_arm64"
      sha256 "875fe60f059da22a93b972fec19190f9b9e3ccf3461b3785a7e2561193884bc5"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.919/nuon-lsp_linux_amd64"
      sha256 "12492580c289feba322bf1561ed097a31c49fbd228475336c33ae8a11c392cfd"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.919/nuon-lsp_linux_arm"
      sha256 "857d89d09c056e14dbe8fd44c399719824bac9d32af403e3237cb15576e9f3fa"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.919/nuon-lsp_linux_arm64"
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

class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1284"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1284/nuon_darwin_amd64"
    sha256 "ea73eb9af533eb64228601d886a8365f59213ed9efbc7321b5f4988ada7e186b"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1284/nuon_darwin_arm64"
    sha256 "dd3ec91cb02c34e43e4cab1fb42fa132ea251a120e2c5576f505ffe6100399bf"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1284/nuon_linux_amd64"
    sha256 "41775113a2391bfe0c8e1cdfdbcabf40b7a616247353df5748615a523855fde1"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1284/nuon_linux_arm"
    sha256 "459b7b6a49aa78d6cc18c321a07dea5690f6e03d58862f0aded0d68255d7582e"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1284/nuon_linux_arm64"
    sha256 "93e66915e28100f1f5af01aed184a27ef685f1645bf8d7e3c56651454881e5df"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1284/nuon-lsp_darwin_amd64"
      sha256 "6424fe5d4e4c0f16929d0eef5f213719003eaea1df9770898a8719689223f761"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1284/nuon-lsp_darwin_arm64"
      sha256 "16cd7302b6edb04b80db23e242f32a9110acc27078b3fc305ebfee9de908f0ee"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1284/nuon-lsp_linux_amd64"
      sha256 "01b18eac9a39cbaef2dd27eacf8942fac7237eb8b991f7372a631b682d270f7c"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1284/nuon-lsp_linux_arm"
      sha256 "ab9b31f0dab0320c0d669ed9792505f369f141cb9eddc6731004c1003e6bacbf"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1284/nuon-lsp_linux_arm64"
      sha256 "ac563bd30c78d61b13f2bc8d522590c61c715d14ae460a4eeeac3941e71fd27f"
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

class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.911"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.911/nuon_darwin_amd64"
    sha256 "240e06a4dc5e9412e57ffc182af7a127a0828595080e321e8ad7d26eb0ced64f"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.911/nuon_darwin_arm64"
    sha256 "fa1518e9ba939dffb5d465fe4f4744898fb4a5550423695146d90c84b65a84b6"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.911/nuon_linux_amd64"
    sha256 "54a22c1b43cd4604fb52f546f4a852be30e6c7a4da7a338802626668151517e1"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.911/nuon_linux_arm"
    sha256 "958d4e987fd6c196cb3cf5a7abefaf68f939f17da5fcf7a7347b2ed76288feaf"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.911/nuon_linux_arm64"
    sha256 "9f6b8ab10edd8f1da2455994a9a45b7a6cb2ca7e75f381bc7c1a917dc3a9bdfa"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.911/nuon-lsp_darwin_amd64"
      sha256 "366b6bb6055f44270c3a9dd721b8031cbf53e1f3c3ca9c492dd28ad21c32bf49"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.911/nuon-lsp_darwin_arm64"
      sha256 "20fcb5d4002a4a443d080d0a5f307cfc72c450e89d54f2253f5d64c385690d6e"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.911/nuon-lsp_linux_amd64"
      sha256 "365782594b3db804957cbb8a82c517e2bdcad6a29382a1a2418d1c204585a98e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.911/nuon-lsp_linux_arm"
      sha256 "5d30df0d132d3e787225e360caf598facc8638ae5d7b7750891b50425fe41b81"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.911/nuon-lsp_linux_arm64"
      sha256 "22b75b63748ecaaa67fe88f7182bce15b42e57e14d6cf14f0beedd8117538a81"
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

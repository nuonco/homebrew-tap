class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.935"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.935/nuon_darwin_amd64"
    sha256 "52b942e97d784033497213311c25b8aa54437ce861c4a9f5178adce92d6cd097"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.935/nuon_darwin_arm64"
    sha256 "83b8f9eeeb7ec55b081b2491ee9a48826fc03a5e12d9ea23c441e5386e21197b"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.935/nuon_linux_amd64"
    sha256 "ce5b896a0a2efa7d7464984fe86f0eed61204ad55899f7f1adfea54062a9f3c6"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.935/nuon_linux_arm"
    sha256 "65c8bfdc1de9c427aa9b776291c10b7464292e6390be62da6d1e636aa07338f0"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.935/nuon_linux_arm64"
    sha256 "1e39a2a97d4b7a11eca78cfc899717e1f1c321b8bc88a8356c48ab027755c9bc"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.935/nuon-lsp_darwin_amd64"
      sha256 "c7db0f8831cc472f839d735be92b3c6d1329cafddc9a6363c6ff415dc7bde72d"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.935/nuon-lsp_darwin_arm64"
      sha256 "80d87f260fd5994868877b872c3c79dd1e974c4441d8ed745fa2f22bc27c7ca7"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.935/nuon-lsp_linux_amd64"
      sha256 "cac045e3cf768e12018ec4b43d1b1c1383a1085a52875c0ab050c2e381d1330f"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.935/nuon-lsp_linux_arm"
      sha256 "eca5c5a8543fc389f6dcf0593cf300873b28bda1cc0f2e51c20dc49b2f060126"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.935/nuon-lsp_linux_arm64"
      sha256 "de92a0986c51e36b46f730c70de6c5820c937ffe7f16f2f4008e23dfd84155e1"
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

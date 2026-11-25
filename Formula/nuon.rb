class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1303"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1303/nuon_darwin_amd64"
    sha256 "c9cc818d700cf7001d7820902d512cf1c8aacf77587870081bb0bae9992b5647"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1303/nuon_darwin_arm64"
    sha256 "2b5a3a0c5429671c57ea3cc7b2a7d0758f70a34ab28b54278017fcb120fceaba"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1303/nuon_linux_amd64"
    sha256 "70bf9b0c67bcd0674978159e5a88d6c7f89cb4b3529b319314b3c1ff87a6650d"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1303/nuon_linux_arm"
    sha256 "6427581d9334321234815ccd835bcdf94caa3d968d879e42b46aeb8cc70c730c"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1303/nuon_linux_arm64"
    sha256 "ad0c70e81d24f7c51e4b0b9a9a124c910dffe3ee16ce98dff148f67c6af7260d"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1303/nuon-lsp_darwin_amd64"
      sha256 "2a7f4990a9ea8f7908aa4d8c4a584782e634917c79cfc7826111104557ff2d4a"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1303/nuon-lsp_darwin_arm64"
      sha256 "6af3bc9311dcf3bb8e07ecfc06f53d08faeba5261296987f02c76dcb27b710de"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1303/nuon-lsp_linux_amd64"
      sha256 "26b47aa17ba98d9730c87e1da052ba7f68eeb5d1fa06c07accb18c9f23ae0682"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1303/nuon-lsp_linux_arm"
      sha256 "351966de38c1a7eee97bcc70c42acfe67e8368d7091aa46ca55ce4d6498c8a84"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1303/nuon-lsp_linux_arm64"
      sha256 "044ef99782d0f5346b97c873661dda694e60210027b7eb5a78d6c25f8d435d4c"
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

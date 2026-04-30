class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.910"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.910/nuon_darwin_amd64"
    sha256 "7b1852fac1e4a1629db610a1592a0ca59c2ba8800e4bce53605669ee330b1877"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.910/nuon_darwin_arm64"
    sha256 "90c9af468da94fa3b8cfe4d47a1f46e0577063684967eda5244b76661d9b2b90"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.910/nuon_linux_amd64"
    sha256 "a79ee571553c58c569633ea5f73c9d9ae48dff25772a1baf4aba16db5bcbe97b"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.910/nuon_linux_arm"
    sha256 "6dad54e0ad1c8e0a02da8c9a6219e0759aac6403dff65a6d0ae3e48230710517"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.910/nuon_linux_arm64"
    sha256 "e7bd2f4e1725ca6fb192928399c81c8a6ccfe7f790a39894ead9f9f4170cd6c7"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.910/nuon-lsp_darwin_amd64"
      sha256 "366b6bb6055f44270c3a9dd721b8031cbf53e1f3c3ca9c492dd28ad21c32bf49"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.910/nuon-lsp_darwin_arm64"
      sha256 "20fcb5d4002a4a443d080d0a5f307cfc72c450e89d54f2253f5d64c385690d6e"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.910/nuon-lsp_linux_amd64"
      sha256 "365782594b3db804957cbb8a82c517e2bdcad6a29382a1a2418d1c204585a98e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.910/nuon-lsp_linux_arm"
      sha256 "5d30df0d132d3e787225e360caf598facc8638ae5d7b7750891b50425fe41b81"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.910/nuon-lsp_linux_arm64"
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

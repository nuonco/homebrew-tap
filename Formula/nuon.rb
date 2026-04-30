class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.909"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.909/nuon_darwin_amd64"
    sha256 "68a703f4fadbccef064f1b542e318425c8e23967cd2a24a7a861411974369468"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.909/nuon_darwin_arm64"
    sha256 "82433a8c7dee2d9855c10e9143d92776c9b483a3654d9b0af9ccf6a3a54883ae"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.909/nuon_linux_amd64"
    sha256 "78a4c0abb998b2922664190d891d90a8a4074520c0632ab2fc821e70ba2cddd8"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.909/nuon_linux_arm"
    sha256 "57a014e7b3d21892215893404304f6a39772f60f5794b68aa9e87c0bfd62e1a2"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.909/nuon_linux_arm64"
    sha256 "7caa85cef6aaf52397329c60c651efeaa7ab1c209f1d4b4b0477c7ada669b0a3"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.909/nuon-lsp_darwin_amd64"
      sha256 "366b6bb6055f44270c3a9dd721b8031cbf53e1f3c3ca9c492dd28ad21c32bf49"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.909/nuon-lsp_darwin_arm64"
      sha256 "20fcb5d4002a4a443d080d0a5f307cfc72c450e89d54f2253f5d64c385690d6e"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.909/nuon-lsp_linux_amd64"
      sha256 "365782594b3db804957cbb8a82c517e2bdcad6a29382a1a2418d1c204585a98e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.909/nuon-lsp_linux_arm"
      sha256 "5d30df0d132d3e787225e360caf598facc8638ae5d7b7750891b50425fe41b81"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.909/nuon-lsp_linux_arm64"
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

class NuonAT0191302 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1302"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1302/nuon_darwin_amd64"
    sha256 "49c7f32e8181f26330d1aca6dd64cb02115666ad9b0dffdefad2e698e0c5fc47"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1302/nuon_darwin_arm64"
    sha256 "69f01dbfd642eba42dd26de0188a26e01b9b5424365cc9324887967358374a0e"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1302/nuon_linux_amd64"
    sha256 "9233a91f125f89bc2b40371fe069b9629f69dc590325abd6c1af67b1c7f7f543"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1302/nuon_linux_arm"
    sha256 "fd87c2539db90cf8e0c6bb0fbe36633b0ec984c289edfa01efdad2385226bef1"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1302/nuon_linux_arm64"
    sha256 "04deee51fba5b1430a14d0da1502f636bbab111d5bcbcd2f2aa73ae8a30eabdd"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1302/nuon-lsp_darwin_amd64"
      sha256 "2a7f4990a9ea8f7908aa4d8c4a584782e634917c79cfc7826111104557ff2d4a"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1302/nuon-lsp_darwin_arm64"
      sha256 "6af3bc9311dcf3bb8e07ecfc06f53d08faeba5261296987f02c76dcb27b710de"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1302/nuon-lsp_linux_amd64"
      sha256 "26b47aa17ba98d9730c87e1da052ba7f68eeb5d1fa06c07accb18c9f23ae0682"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1302/nuon-lsp_linux_arm"
      sha256 "351966de38c1a7eee97bcc70c42acfe67e8368d7091aa46ca55ce4d6498c8a84"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1302/nuon-lsp_linux_arm64"
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

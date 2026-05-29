class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.976"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.976/nuon_darwin_amd64"
    sha256 "3afa5c67b9eb0af9d64dbded5aa0f6738eb3dc0fabf46277126b2ceb746cef20"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.976/nuon_darwin_arm64"
    sha256 "5179cabde95e4603c5da173efee80c0aee16cbe696042c06b3af55da11bc9195"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.976/nuon_linux_amd64"
    sha256 "28e3c104f6bf76cd73904e5319a3d14d935613a2fe0d78e91cb4a5c8613af1d6"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.976/nuon_linux_arm"
    sha256 "1373cf3c72a157c2e6e25938e8891bd95758290927ad7ab9044d55f44d919c22"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.976/nuon_linux_arm64"
    sha256 "275052c62cd7cae4f5ae3170475d6ae53666ce5d8b59a1f18882097b6356801b"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.976/nuon-lsp_darwin_amd64"
      sha256 "30308151cef56916ea6b5593be88806ad7a7d3bf8e981cd93f40da0fc121d759"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.976/nuon-lsp_darwin_arm64"
      sha256 "4dc835b103d8a5239042679886c95e340211858671bb725e576aa2db36915bed"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.976/nuon-lsp_linux_amd64"
      sha256 "776a0d8a8eac536dfc9528c055cce981c50ff99e64ecea9a263c72f0342b09ad"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.976/nuon-lsp_linux_arm"
      sha256 "915420df822be9fe94ad31a600552af63e6a4c5fdcd3fc141e0907176060bf42"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.976/nuon-lsp_linux_arm64"
      sha256 "7fa1018de798bfb50977cee8d226f28220bcbd5e5de2d390cdad0303de53ffb6"
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

class NuonAT0191058 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1058"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1058/nuon_darwin_amd64"
    sha256 "c3bf52913dd8c74a27c9cfe2ce0a645262787be7c1980b097a0ff4d068cb290b"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1058/nuon_darwin_arm64"
    sha256 "d25332937ee1c7d9b85cbeb88a02a9650ea0fc54cba0ac3ff582e004c0706a5b"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1058/nuon_linux_amd64"
    sha256 "995edfb2f9eeb6065a10b90935071744adff1f79a3aa361a55e92486829b330b"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1058/nuon_linux_arm"
    sha256 "067e81c986c7ec7473f12f59fbcb376ab4a5a3d278576de97ecd7cf3545ece5d"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1058/nuon_linux_arm64"
    sha256 "31c01f44f4b3286499aea4f04f57786f53b45334b83f5e5d672606ed256adf75"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1058/nuon-lsp_darwin_amd64"
      sha256 "9c6bf03ee855956feb074cb42f7cf4c533f58d77407a6c1f2321b032f59a14cc"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1058/nuon-lsp_darwin_arm64"
      sha256 "ec95054c76c7e58d9af3b12b07b810e29dc5f9eff2f91991efb5fe57f8103ad4"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1058/nuon-lsp_linux_amd64"
      sha256 "a7066ea18ace26c8ded42b1ca5881f5209566271a8474407a252c024582e7c99"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1058/nuon-lsp_linux_arm"
      sha256 "ecca4c4ceb8c9589cdb23fd097d338ae8f4cfe2d0b9b743d62ec4cc401ee5dd3"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1058/nuon-lsp_linux_arm64"
      sha256 "7ccee00185d89852bacdbc4f2c90fd5083b022467d41fe3cf57fa76da4a94b62"
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

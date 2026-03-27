class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.856"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.856/nuon_darwin_amd64"
    sha256 "1264a8f750b9b289bdefe7deaf7e947888f19ff7cf66bb775a63043545e18e5d"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.856/nuon_darwin_arm64"
    sha256 "6fb8a4e471f2344558ad7f0762e0aee67fc4e1f4132b23451afd27b3d9e02c75"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.856/nuon_linux_amd64"
    sha256 "c78a32f7ac9362189a60ac0009b48af9cff550293f2d87031d039364b09571e7"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.856/nuon_linux_arm"
    sha256 "080e2c27d5826c9c82d2ecd07915062eb29f2098336b23c99bd61c479525eee2"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.856/nuon_linux_arm64"
    sha256 "26fc52c82cdccf01a928bc3d3ad10c2e53a101281003ba9f03bd51aee40253ef"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.856/nuon-lsp_darwin_amd64"
      sha256 "61579a272c1eec7aed27d3d7d3e0d2b507a8877227bb92300445872090d46285"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.856/nuon-lsp_darwin_arm64"
      sha256 "e5594bf53c8bb73ea9d1784af67d09f25e7fdb5e61dab0affa3f6461a6441308"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.856/nuon-lsp_linux_amd64"
      sha256 "10dc48c990da0ed16cd5cf96eb9630352c2455f284215da177d0a5b684904d2b"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.856/nuon-lsp_linux_arm"
      sha256 "6ca9cba22d5748c42ca76117a567f853b7af4628a2d94646372e9247fb9cb798"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.856/nuon-lsp_linux_arm64"
      sha256 "c96d70a63ac52615779a280d3da79393855fb47d10e92a4e8327764cfd6c7010"
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

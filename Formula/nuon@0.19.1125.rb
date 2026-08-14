class NuonAT0191125 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1125"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1125/nuon_darwin_amd64"
    sha256 "ebba7109d96097457b2d80eb45f7577646e9c7b1d2378d1390294095decb8ae3"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1125/nuon_darwin_arm64"
    sha256 "69a83efda440446d39018edc862a612dcbdf882b1e8dfbdc453a91e64f3a8e35"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1125/nuon_linux_amd64"
    sha256 "67c0d93fc017d1daedf59aa860f4e50e7ba987993dbe28c85503eb3ce0ce3951"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1125/nuon_linux_arm"
    sha256 "906c5e9f0fac892a56e6ba321731c47e1038a0ddfb2ceb20021696adec1a3cad"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1125/nuon_linux_arm64"
    sha256 "8301d613b0c183fa0123d904085d76e676d75aa4ff6a1016c8eb405e81d1b571"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1125/nuon-lsp_darwin_amd64"
      sha256 "ffd0a9a5fd632e72cbb9bf4c0d2bede5d085900193fc9dc3722fcfedcfc40504"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1125/nuon-lsp_darwin_arm64"
      sha256 "d573ad0be402b607c5f4efe90f91fda983d086adce6a8e1d73bbae076446ec93"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1125/nuon-lsp_linux_amd64"
      sha256 "41ecac29f9c8f2ab0a11b581365ee05fcdb7bc71a3bb9858d3e4cb11f04c0b6c"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1125/nuon-lsp_linux_arm"
      sha256 "8dffa84dbfb50312821acff7a58a855ac62e883e0463113171d9673871298d73"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1125/nuon-lsp_linux_arm64"
      sha256 "a40c1f1bb7490452bc9446884587768759d26772e9d0623a18a26033c9e19c8d"
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

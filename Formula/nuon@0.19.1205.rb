class NuonAT0191205 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1205"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1205/nuon_darwin_amd64"
    sha256 "61dd9e0a198760a6e4b4e2d4f3ad4a1a2b39b3f68d94d533883484a47be2e5c2"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1205/nuon_darwin_arm64"
    sha256 "12cd6a1e77be86614f6565359900d5a4b603f27549f1057b043b415a05d673c8"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1205/nuon_linux_amd64"
    sha256 "a9d3928ff6beb9e1613f9d8e7c28d4d315f74275eb8815c90da4317468636786"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1205/nuon_linux_arm"
    sha256 "e81f85d15d752c040101cc9990d517c65a1fa17b470a24739837adb77e53ac2a"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1205/nuon_linux_arm64"
    sha256 "3f3c72b1527ca1326c4f138c74a257805681f1945b931e984e17704285cbc904"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1205/nuon-lsp_darwin_amd64"
      sha256 "63d88dd9abde58497b82b945f3caf0fa35ffeaa3cbb868992a083bb6666ef2b2"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1205/nuon-lsp_darwin_arm64"
      sha256 "cca558dc73c26be35115aee518fe143dd5695cb74825b57ed9d5acf3f685d2b3"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1205/nuon-lsp_linux_amd64"
      sha256 "b5932c136518877a0e8103fe07e57fe43399e309e0299102104302ba54b67790"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1205/nuon-lsp_linux_arm"
      sha256 "2a488f201f21aba19312bfea5a6b86ad412ed07186de352e93300d2dfb00fee8"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1205/nuon-lsp_linux_arm64"
      sha256 "b099ed4fead7da06dc46721237a137c9c60e83a50d21002102c25509aae9a88f"
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

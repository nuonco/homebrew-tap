class NuonAT0191204 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1204"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1204/nuon_darwin_amd64"
    sha256 "30f878d22cea74bd379f2f2f6a757e56be888699db098d889c1988d1f5c64a97"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1204/nuon_darwin_arm64"
    sha256 "845282b581bd775b85341da00923e4442a6f7f40a3ed79c87fb9e1f6f15dc56a"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1204/nuon_linux_amd64"
    sha256 "1e0fa55ef3d0077b530ae73cc2ab16f6dd2484224edffed5f72c3597ba53790d"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1204/nuon_linux_arm"
    sha256 "369d71240666cb92cc45b1c703bc8c2ea775dace238b7776c418a3f1aa8aee71"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1204/nuon_linux_arm64"
    sha256 "0c8230a68c71dc64611de5aaf9331aebcf74749c7841df745ade183b9e5993b2"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1204/nuon-lsp_darwin_amd64"
      sha256 "63d88dd9abde58497b82b945f3caf0fa35ffeaa3cbb868992a083bb6666ef2b2"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1204/nuon-lsp_darwin_arm64"
      sha256 "cca558dc73c26be35115aee518fe143dd5695cb74825b57ed9d5acf3f685d2b3"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1204/nuon-lsp_linux_amd64"
      sha256 "b5932c136518877a0e8103fe07e57fe43399e309e0299102104302ba54b67790"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1204/nuon-lsp_linux_arm"
      sha256 "2a488f201f21aba19312bfea5a6b86ad412ed07186de352e93300d2dfb00fee8"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1204/nuon-lsp_linux_arm64"
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

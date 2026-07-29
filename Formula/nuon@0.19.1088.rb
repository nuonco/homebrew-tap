class NuonAT0191088 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1088"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1088/nuon_darwin_amd64"
    sha256 "c36d293de676613a685bc1e8b4d125128886809ddafca16a06666ef9ac719ed6"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1088/nuon_darwin_arm64"
    sha256 "a8048bf58cf9ac707f0e645a13b43abc9d51aa317f8f222302479b5dd980823c"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1088/nuon_linux_amd64"
    sha256 "fbd5b8b32775c9d18438a9e1b0cdca8fe7d350ffd7fb8dada32c76f5cc8d0650"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1088/nuon_linux_arm"
    sha256 "bba328bbe59b62f80d4d9978ca6e015f8b3357dee5b8d00a08daca592af5866e"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1088/nuon_linux_arm64"
    sha256 "2f2fdbe816da1f878292a5671db2b6be1f3d6189261628deb1cce6d48cd9ceba"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1088/nuon-lsp_darwin_amd64"
      sha256 "80efa12079b5b12c8dcfee64119a8fecb8388d3040ee980eb24fb1a379577165"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1088/nuon-lsp_darwin_arm64"
      sha256 "072c7b25844f61787d65053c9da63ef6663a23d2eb18d722d18b7db77d71d1a0"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1088/nuon-lsp_linux_amd64"
      sha256 "5311920b1715b50dc6f4fead5ace11743aed95e8175a5904bc199c773d071f55"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1088/nuon-lsp_linux_arm"
      sha256 "7d1c6b4b675949faf8a15871198ca81cd6d2617c0795fb3b5ba957b73bec5328"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1088/nuon-lsp_linux_arm64"
      sha256 "f7bd387bbf47b864022311a24869c12aef0a08211986ef6be559db801fbe51b9"
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

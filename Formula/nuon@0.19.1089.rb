class NuonAT0191089 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1089"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1089/nuon_darwin_amd64"
    sha256 "78e64d2d21752c120111cb38a9532f0fcd6de9949a231aa9912a55918ffd01a4"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1089/nuon_darwin_arm64"
    sha256 "a0a036ecffd33e7f9b94f4e01d315bf06472878455bbc81e1fc54c59b326a48c"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1089/nuon_linux_amd64"
    sha256 "64e8001507f2aa86318e3631bfb8091d36a71bcb8a384a3fecc58d315e9afb1d"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1089/nuon_linux_arm"
    sha256 "cf53bf3d7f8eb9e30d6e0a897057d7c1d94a775e28cb6eeeca2327e1bc837af4"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1089/nuon_linux_arm64"
    sha256 "fe8cf5ec6b754b1a046e7762f6a6a37fc6fc0da57a50a0230e681b6be7607d49"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1089/nuon-lsp_darwin_amd64"
      sha256 "80efa12079b5b12c8dcfee64119a8fecb8388d3040ee980eb24fb1a379577165"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1089/nuon-lsp_darwin_arm64"
      sha256 "072c7b25844f61787d65053c9da63ef6663a23d2eb18d722d18b7db77d71d1a0"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1089/nuon-lsp_linux_amd64"
      sha256 "5311920b1715b50dc6f4fead5ace11743aed95e8175a5904bc199c773d071f55"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1089/nuon-lsp_linux_arm"
      sha256 "7d1c6b4b675949faf8a15871198ca81cd6d2617c0795fb3b5ba957b73bec5328"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1089/nuon-lsp_linux_arm64"
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

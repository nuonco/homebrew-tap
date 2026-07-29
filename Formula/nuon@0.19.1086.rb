class NuonAT0191086 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1086"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1086/nuon_darwin_amd64"
    sha256 "6376b0d6f5cce757f771e2d643f93c988cd70cf455b26798481c2b40203876ea"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1086/nuon_darwin_arm64"
    sha256 "26e159541744a447e7723c498487436d7272df9c0e5599176306b177b7e26b40"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1086/nuon_linux_amd64"
    sha256 "46e6efe11890425e79c041a87313984aa002813747ccb545cd063fdbc16e521c"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1086/nuon_linux_arm"
    sha256 "dd446ea3c103ea10d60989064a30dff215836de569afa4350073f4db82f51191"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1086/nuon_linux_arm64"
    sha256 "71deacc532cd1e6f760bb0388c2a83cbffaef3cfdaceb52473732d1e5eda9f03"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1086/nuon-lsp_darwin_amd64"
      sha256 "80efa12079b5b12c8dcfee64119a8fecb8388d3040ee980eb24fb1a379577165"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1086/nuon-lsp_darwin_arm64"
      sha256 "072c7b25844f61787d65053c9da63ef6663a23d2eb18d722d18b7db77d71d1a0"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1086/nuon-lsp_linux_amd64"
      sha256 "5311920b1715b50dc6f4fead5ace11743aed95e8175a5904bc199c773d071f55"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1086/nuon-lsp_linux_arm"
      sha256 "7d1c6b4b675949faf8a15871198ca81cd6d2617c0795fb3b5ba957b73bec5328"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1086/nuon-lsp_linux_arm64"
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

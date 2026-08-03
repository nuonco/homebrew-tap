class NuonAT0191102 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1102"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1102/nuon_darwin_amd64"
    sha256 "f2708d48ffa2a10a63e6408ad12e31b5003fed98296b04bb02a3df6a4e220bb4"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1102/nuon_darwin_arm64"
    sha256 "e6a8ac4d7a45bd99fbc640e57b31ad066288d8855ca64a8a261f20d0e25c79b6"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1102/nuon_linux_amd64"
    sha256 "73b8c968816aae6a370ede5c220d72299d2c6ca1770d0619bd3dc3431dfd275c"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1102/nuon_linux_arm"
    sha256 "5fbb8f43dc0313bf729ac7f8948888306c4a39324f0d458b7bb8b8e43940d64c"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1102/nuon_linux_arm64"
    sha256 "071d2c8f44b58f97d8b0cc488051dc34d4e975d88e17d348223102bddfae20ac"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1102/nuon-lsp_darwin_amd64"
      sha256 "b84ee20370917d1b2ceab0f1a018cf0fe5276857bf371d0c46f35cff61acaf63"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1102/nuon-lsp_darwin_arm64"
      sha256 "2a9e8b886d08bb6649089aaebdb52b04bcc29ec05a88ed4c5dd3f7518a25919f"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1102/nuon-lsp_linux_amd64"
      sha256 "331d14bcc4b6a0f2a4624dd091faf9da395c60a616b8ec7c2699ecceabea11ae"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1102/nuon-lsp_linux_arm"
      sha256 "8bf80e42fd1a10fe8f85167709c3cebf2ed63eb57bfd7e7d001b08753499e471"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1102/nuon-lsp_linux_arm64"
      sha256 "ada73e3bc3363079839d6e52a704fcb1ea1e8789da6d8e14c7730de04abe11bf"
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

class NuonAT0191115 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1115"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1115/nuon_darwin_amd64"
    sha256 "f91a6ff07f6fa77f787f3e5ee55e33bccd781e2e863317ee635d07d498fa49b9"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1115/nuon_darwin_arm64"
    sha256 "20864a5473a6339c0fd2f63125dc127fe90817f3e70022cdc7b65bc595debff0"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1115/nuon_linux_amd64"
    sha256 "7a0d07b371b028d96f879b9da8a901dbc636912cc2449348de3a50d2f3cf1ddd"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1115/nuon_linux_arm"
    sha256 "19895570c46a7733928639f18c6426cc1f353956857c411bb0b83b361556357a"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1115/nuon_linux_arm64"
    sha256 "a448402b25924260bc2dfb2d59dc7b0f5e6e07edafc48f0b91e11d3efded92ea"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1115/nuon-lsp_darwin_amd64"
      sha256 "f6d1fcb88036923af710ba8eb9a908a0c7920423b4fcc240577bed4a2fa2b5e3"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1115/nuon-lsp_darwin_arm64"
      sha256 "26046728f4eb66fd5e461c39e0ef75a630226cb87791b41606aeedec0a362295"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1115/nuon-lsp_linux_amd64"
      sha256 "8151737fb607e3906ce99dffed2558e72d07de2401c0a58c914b4ee4f4b451b6"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1115/nuon-lsp_linux_arm"
      sha256 "b76a5da7613424176f2ab22ea4effd7ec33a695dc7b6d05b3f9265f2a0ca2ce6"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1115/nuon-lsp_linux_arm64"
      sha256 "a4a06e64fa7c95dd47e8e8d534e20d0ecbf4e13e5b5cde2e4ba2d57c0402b369"
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

class NuonAT0191254 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1254"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1254/nuon_darwin_amd64"
    sha256 "958aa6aa4aa203402ad5cdf3eaeaf86979b2bbc260f4a88b2618da4b7e29a1b5"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1254/nuon_darwin_arm64"
    sha256 "859b89d5df431be82d1c5553d9932c6e31a1c9997091b777a4062a8def99164a"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1254/nuon_linux_amd64"
    sha256 "418b526c58813214c25dd58711f60b7363012ddc094240d43dcfcbee056c43d6"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1254/nuon_linux_arm"
    sha256 "be0553f1629b1bb4a841a71eb93bf0c5475deebc2aaa3e1596e701746661fd7f"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1254/nuon_linux_arm64"
    sha256 "aba4920468c4fef61a08177a728388b986e28d6f52b071b7521ca4ee7d034a21"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1254/nuon-lsp_darwin_amd64"
      sha256 "a03b44e574bb530ef037475235b28eefdb3ecd14b6222f3cc89cc113fc388f4c"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1254/nuon-lsp_darwin_arm64"
      sha256 "5e1377fc1730d4a9b34b0e28984590355d4030085236f799a71e42cfb2dc2e22"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1254/nuon-lsp_linux_amd64"
      sha256 "4a9889f5efafdc4c618f9a67005c1a8fabbc49ad8369974722f8a16c3c37171e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1254/nuon-lsp_linux_arm"
      sha256 "a9321c72181aba6d7f73a43af7a7d21728f7c5d073f438ea58e0ab80e12ec7d4"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1254/nuon-lsp_linux_arm64"
      sha256 "b7897917bae7e51e71205ffe1e0a1456fd423746df3157c98064b96a2007da48"
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

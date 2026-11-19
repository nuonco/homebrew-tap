class NuonAT0191297 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1297"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1297/nuon_darwin_amd64"
    sha256 "5d62e8f9b0f7c8cfa9e4171abc8029f789f5954da6b795220813af7dea6025d0"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1297/nuon_darwin_arm64"
    sha256 "8c0ebd2bda7298d02f6a131de0261ba9f7360bc0d48c431bf22ea80c46ea20a1"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1297/nuon_linux_amd64"
    sha256 "020ed97b226370a420c291d0d8e83b6e483948f96ca4a3ab8afd5a0c72cf5475"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1297/nuon_linux_arm"
    sha256 "ad5432f6b30e2d324b512121eb070a10ed472feb1b959a4e9175b553612fa47a"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1297/nuon_linux_arm64"
    sha256 "904ea1cf32de6c2ab95ecfd91dec28348219a70c014008a8bf12bcacae0b1caf"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1297/nuon-lsp_darwin_amd64"
      sha256 "5b28cb1e0417fb9961b66683678a0fa6591481b710bbfe76354a338682a07072"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1297/nuon-lsp_darwin_arm64"
      sha256 "7f53b8733dc2cbef289128cab49157d9207c29120742bf2cc3f10955a233400e"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1297/nuon-lsp_linux_amd64"
      sha256 "989fec5f594c965bc4fdf7973c876b4eb083ec0e57c9f674f08ff98aa043f066"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1297/nuon-lsp_linux_arm"
      sha256 "8258ae7eae2cfacdda73925c9b1d1bbf1fb8adee50531fc2eb47c061561c3090"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1297/nuon-lsp_linux_arm64"
      sha256 "a74b57b431c67a8105e21b58b371241759fb353ee2b1d38e1caf12a512a81a92"
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

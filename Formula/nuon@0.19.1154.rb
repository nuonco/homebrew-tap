class NuonAT0191154 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1154"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1154/nuon_darwin_amd64"
    sha256 "90170391c6a9140d0a9042b2144f334d09cb75d8703abb83480d07d352369811"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1154/nuon_darwin_arm64"
    sha256 "1dec35103dfbebce21e3dc8d51d34dce21c831098d78479efcd18e49c5a6fc12"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1154/nuon_linux_amd64"
    sha256 "98b90deb2e3a5f94d410fd1d7ce462c219400f80e1fd677ccf29f5d2aac0c5f4"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1154/nuon_linux_arm"
    sha256 "3e95e9d38a8fc6e1586563d74a0856cb921fc63c83388b7b55c6bd464ee26486"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1154/nuon_linux_arm64"
    sha256 "22631405419ccdaec053221ca615dda8cdaeb2e82fc17c13491d63f5a28c27c6"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1154/nuon-lsp_darwin_amd64"
      sha256 "eeea45c8d5da4f9a3f7174b0cba660d6bcb336a54b210d8f9aba77e6dc2ac169"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1154/nuon-lsp_darwin_arm64"
      sha256 "dff31c16dcd2233b3fdaf80e2f6452e570d1dcb78e7d63d1c6418357970050c2"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1154/nuon-lsp_linux_amd64"
      sha256 "210085596968b762658e5ea741f0169069f699219077e21fbdc0c076ab6895e8"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1154/nuon-lsp_linux_arm"
      sha256 "5aa2e5cff9cf431ded7710458b741b6a065c3825015bd89e06feb49bd1d7328a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1154/nuon-lsp_linux_arm64"
      sha256 "965a455119c4731fb90ba40e9c8b6f5be32e9b5fcd074cb71f362e6147623497"
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

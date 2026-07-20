class NuonAT0191074 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1074"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1074/nuon_darwin_amd64"
    sha256 "438c205bc63a5ae9b446823d5cfee982b62d1ac2eb05ea7b4517aaacaaa39db4"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1074/nuon_darwin_arm64"
    sha256 "5c0d092279985025f3d5d714b3006a92c10f824c04a27eb9e1ae4ce9a81d3309"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1074/nuon_linux_amd64"
    sha256 "fc0f93e206c47b9f3053677c5d1d39268cd9eb5c14fd32be3e3fad5053a516b1"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1074/nuon_linux_arm"
    sha256 "b6c7527c300018bdf7d97ed733dd922defe9d47762e30439464c313d726b2b69"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1074/nuon_linux_arm64"
    sha256 "125ab69cc7ddb343bbc056e5d41af6f13818c3edf08a3c365c5a58eaed2137e7"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1074/nuon-lsp_darwin_amd64"
      sha256 "25e595c512f827e2901f5da2ee2a5c394307377ee9fc8e72fa5bbe311d776633"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1074/nuon-lsp_darwin_arm64"
      sha256 "a53641429d52cecbd4a456b378db32c3d50026779867e226778d02aa21502b1f"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1074/nuon-lsp_linux_amd64"
      sha256 "0e9769704c43917f8b4cb956a7cd463fe3064ee30c6cd398970c98fb594aff95"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1074/nuon-lsp_linux_arm"
      sha256 "ce694d77722f76182dd273a7ef2b124cbe153a5c281218f0a491d022fe5437a4"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1074/nuon-lsp_linux_arm64"
      sha256 "38a7c588e6b48d36d8459692be538b8865f4e1e5f33c9c375c1e28e60a70e34f"
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

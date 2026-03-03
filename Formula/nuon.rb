class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.821"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.821/nuon_darwin_amd64"
    sha256 "ebfb68aa6eea90ac8ec86e4ada92b396846068dd7c58f4a9e5f8c41758dfbad4"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.821/nuon_darwin_arm64"
    sha256 "5ad7ccfcaea2df90952182c2d43d2730cd25a936e102b51146fb727d689e0c79"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.821/nuon_linux_amd64"
    sha256 "9e2909292c5fd1d5bc3833984dc0f87d4f07cfd91c6dcd178fd397a4783c5f45"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.821/nuon_linux_arm"
    sha256 "c7bfa97898f45d0d93b6ea009ce579940feb6782dbd6af4c0f322fdd061e1791"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.821/nuon_linux_arm64"
    sha256 "2aba8833f9d772b5f8960d74b870c0a66d329ce9ee8e41d5a09b5086092b2952"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.821/nuon-lsp_darwin_amd64"
      sha256 "9229e6b5610690d167bbb306df23c3422b54cd18243fa5aa716c37b7df392a88"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.821/nuon-lsp_darwin_arm64"
      sha256 "ffd7269523f85188890de70ce2e2e6b01255935a69253097dc962608243399b4"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.821/nuon-lsp_linux_amd64"
      sha256 "6a5e26bd268da029e3c8d93fe9885477c87015626f60585585f18da001197b50"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.821/nuon-lsp_linux_arm"
      sha256 "7668432f692d1bf47b823ea1b903d097d7d29b033dfd678b1828a6d22f009542"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.821/nuon-lsp_linux_arm64"
      sha256 "4e3f672425c6308b4994a766e28ec834a3982d48bb9f5b6efede1152c0313b08"
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

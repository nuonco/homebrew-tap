class NuonAT0191181 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1181"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1181/nuon_darwin_amd64"
    sha256 "200deea1a3caf07ef5bc891684aaeead051ddccc2b1d253ae74f7dfdc0e6bf2c"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1181/nuon_darwin_arm64"
    sha256 "aa4b2262b5ca57a020913ed7f64d97a59ccb51a6811c7b180a60f53e8dbdc470"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1181/nuon_linux_amd64"
    sha256 "5170c216ef779da95dd66ce72be9800d0bac74632fe8c9613ed43bfcaf990a6c"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1181/nuon_linux_arm"
    sha256 "9fd472e0bf7d5fff0cd1ef8b8058fc67c7db1891cd38b67eb28416236cd6a474"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1181/nuon_linux_arm64"
    sha256 "2437cc65b6861d26c2871abec4d9211eff0e3051068fb0c0f0053120a10c0d35"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1181/nuon-lsp_darwin_amd64"
      sha256 "32cca7831c3c0139b04ed1e296bf26a48c30edb4f340ad3b0c270e6658de43ab"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1181/nuon-lsp_darwin_arm64"
      sha256 "0ffffd91eefd21198434f8371bc09e8319ab1bf09cac5277fa66facd662ee7aa"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1181/nuon-lsp_linux_amd64"
      sha256 "9c4f553b6ec84396a1a9f6b23aea0c476288001001470cf94d289e2f8d5a0112"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1181/nuon-lsp_linux_arm"
      sha256 "2c0dc46bb573474ca722c35f1b4a15f8666162713c2acdbc80a92e6358d03c16"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1181/nuon-lsp_linux_arm64"
      sha256 "0af4b634c4cf8eaeb765dd522985bf249a91e91686604d66c84691cc45b99321"
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

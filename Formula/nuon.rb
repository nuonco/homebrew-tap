class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1025"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1025/nuon_darwin_amd64"
    sha256 "099c915b856e70a1b8e3ba76505fa04ea2dbc59ea1db55e129b690e6bcaa9fa4"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1025/nuon_darwin_arm64"
    sha256 "3632b43b6558c9c4561efc08b8d003933edc5a6bc4a910b4d54ed94d4e5ad8f7"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1025/nuon_linux_amd64"
    sha256 "a1bedbcee3c2cb182e8311bdaf418513f592752b23569db29f761d2b5464d0f2"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1025/nuon_linux_arm"
    sha256 "ac8775af5daa833d1846eee1d05372b333cafaec7a3baf1f88fcfbb702468daf"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1025/nuon_linux_arm64"
    sha256 "212ede8a4875cb33453039504c0d2413952205efed4b13155fd46d107266e40e"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1025/nuon-lsp_darwin_amd64"
      sha256 "253f25b16e0a8c2bced80da9624ab8115edc406aa861515d60ad4b8c442d6847"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1025/nuon-lsp_darwin_arm64"
      sha256 "c5ff13117846e6c44070210d6d31d6fe2413524091c687c392621145f9bfd922"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1025/nuon-lsp_linux_amd64"
      sha256 "96b82ce1596d15a09fa4193e9664385817fa7e61cfefbe7dd8c13ef9c28bf41c"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1025/nuon-lsp_linux_arm"
      sha256 "9271b530a8185224d192bcc0984a91d59875c1c4620c93614e3e3ffb7d99543e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1025/nuon-lsp_linux_arm64"
      sha256 "de938bc6ff6eabc877675025839acf356e090f36dae8417ae568d3a06507566b"
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

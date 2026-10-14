class NuonAT0191243 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1243"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1243/nuon_darwin_amd64"
    sha256 "826e3ca1b687d25d65d385cea04c9ef62dffafe6d9cb742ccb6af30aea29e677"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1243/nuon_darwin_arm64"
    sha256 "56af3a45a3469c89934a031167975d77e27027192e2e5d4b7cc2ce404628ef0f"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1243/nuon_linux_amd64"
    sha256 "dfa88cd0174add2c01e67fb43e73514d98a3112ac53bc86b75997510be828660"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1243/nuon_linux_arm"
    sha256 "d62a81417ebd469ee4e0a891eaed4d7df86d2bc25b75c8caf7c53505d504915e"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1243/nuon_linux_arm64"
    sha256 "3b2232847ca44b1737adb2db47d2932a419874ba164ca79db35303d5d4ff0cdf"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1243/nuon-lsp_darwin_amd64"
      sha256 "4506efe688e8e931ad1984eabaf3a0ee4980c93e3366ada08669f410f6f915ef"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1243/nuon-lsp_darwin_arm64"
      sha256 "189e7ad18f03c120d5b7a41b1bc6dd8aa0bbc41b82518397c86250e66a107dfc"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1243/nuon-lsp_linux_amd64"
      sha256 "dd72edfa796dab72da87075916a86e28113a3875502cccaea8dd8e61ef67e6ab"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1243/nuon-lsp_linux_arm"
      sha256 "e3b7ed6827f085e781cdec8b5a3c268fa694c9136039453cb3c82a1d39d5ec19"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1243/nuon-lsp_linux_arm64"
      sha256 "dd91528538bb138016346835ae1f83be283700d56ba8ee2e99fa2cf316c0e80a"
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

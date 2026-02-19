class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.798"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.798/nuon_darwin_amd64"
    sha256 "206871c6c107927ef3d97fdad95d863e2fc7d65aead6780f362bf94060acbee3"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.798/nuon_darwin_arm64"
    sha256 "ccbad9acfdd4da89cdbc7ff008bdc3f5f256686dedcbccb1eacf539dafc7b7f5"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.798/nuon_linux_amd64"
    sha256 "a9bdd5aff22e6a84953e6a34521ece89bc896a3b231769911dd438dc2e55e734"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.798/nuon_linux_arm"
    sha256 "95167f159314cd06935f6a7d150e89f19eb0701905dacc7b808310723d88e25e"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.798/nuon_linux_arm64"
    sha256 "3c1951308bc724d741bc4aabc554158b1e0d9e18f2f478aedf9408d6e277ecd0"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.798/nuon-lsp_darwin_amd64"
      sha256 "3a6bcccf6f7b80bf3a1035e4fd5c875618afd25d8e22f7029d2a0cb69011212c"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.798/nuon-lsp_darwin_arm64"
      sha256 "80659897096dcb757867ce2c7aa974c9860529736a3d076c901605dc96928290"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.798/nuon-lsp_linux_amd64"
      sha256 "4bf24ba57c2c43d62a659eb6362f4228dfe4baa2bd1307ec34702cf0ff7ba940"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.798/nuon-lsp_linux_arm"
      sha256 "b20f6031ff062b21c1d3d9ad87ee32a0368b20393318f155b4227432aca4ba2a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.798/nuon-lsp_linux_arm64"
      sha256 "26c1d0febdee4be3302c1297f306d07b12f656655be65f9241922c0a4d211191"
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

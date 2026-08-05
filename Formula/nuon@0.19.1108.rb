class NuonAT0191108 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1108"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1108/nuon_darwin_amd64"
    sha256 "91621e20400156e34076a0697321e8ea98f4556ad3b7a999f4034bc892169c1a"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1108/nuon_darwin_arm64"
    sha256 "c69180521dfe9d4aaa8a811c8cbf3620363304e3d51a70796744ae760f3b0605"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1108/nuon_linux_amd64"
    sha256 "5bd326b7cb0bacd6f154fe2f4c54f1e2c8ea1f590b579e8daaf71966ac784206"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1108/nuon_linux_arm"
    sha256 "f2fd5453e8aa6cf49a9d92a3e984c408d255b49a35614b598380f190f60f45c8"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1108/nuon_linux_arm64"
    sha256 "8b89e81d89c77cc0e7f2ef2922e488e43f68bcd33939dbcad48f8f0b11b382c1"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1108/nuon-lsp_darwin_amd64"
      sha256 "04116cc1a29802509a1663393c5f2e6a2ebd9976fc4a061a7e1c31869e4d7fc0"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1108/nuon-lsp_darwin_arm64"
      sha256 "ff1891bd1bca67517167321be6eeb64427fa76308f97e6435d296d4df5678a0b"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1108/nuon-lsp_linux_amd64"
      sha256 "45dacb2965c6157db424357cf5e1f45c760a9e10788ba56f56704acea1ce4c6a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1108/nuon-lsp_linux_arm"
      sha256 "5bae5025253b64626022a2da3b99842a38ae603f041b78d9e70f3c2e873f5493"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1108/nuon-lsp_linux_arm64"
      sha256 "51056a1bc2040e229c6749fc5f8de1dff331c5c31b46c698ca0c3b9e7c017ccc"
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

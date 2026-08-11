class NuonAT0191116 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1116"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1116/nuon_darwin_amd64"
    sha256 "1a8ed7b7f2b3f4914753b33a5dfeba9757d6b3c2997eb0a2b20baac0f18de1cd"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1116/nuon_darwin_arm64"
    sha256 "7f16a309bb842a2b136f5aebfbeb0a21e882369c927dbfa33e00bdcef1e4d349"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1116/nuon_linux_amd64"
    sha256 "5308c8b13041d22dcece8cf226432c14258e4787979196ccc877f17764a1ece3"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1116/nuon_linux_arm"
    sha256 "d7fdf40db8dbeff904dd30ac6842fc07c33b62a914990e637647bff73c6880d0"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1116/nuon_linux_arm64"
    sha256 "9f26361bc06bf139119277a101dac77a3e8feceed9922846e21b695fe433b47a"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1116/nuon-lsp_darwin_amd64"
      sha256 "a1aac9df4814fd707908025516153e51d853d399ad32a0e9d36480702d5bbcee"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1116/nuon-lsp_darwin_arm64"
      sha256 "fd7b237d9a2b6eb9df12403dc73cf45035ba2beb53d9dde5618ae87dd6bd3812"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1116/nuon-lsp_linux_amd64"
      sha256 "dc0656261eaae8a0f71f2e39b23a3021733327afe4151c6d52b0f149ae845736"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1116/nuon-lsp_linux_arm"
      sha256 "cd348d93b64eada62575433a78b9b862fc357587bd9d07d6ab6566c99b40c1d2"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1116/nuon-lsp_linux_arm64"
      sha256 "eb8dcce7110364f05124d2b9fca558e0650a3ec4f149d5834f7ffe08252fd487"
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

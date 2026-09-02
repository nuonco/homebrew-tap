class NuonAT0191161 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1161"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1161/nuon_darwin_amd64"
    sha256 "75eee6c1bc07171e2d710e69bd4efedd247924ae367868bcb2ec4ccb4f53e260"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1161/nuon_darwin_arm64"
    sha256 "ec832f8b50db99cced5500a3b1222d10f6ab764a252dd3ecdf0e005088a142e8"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1161/nuon_linux_amd64"
    sha256 "3c8cd0b3b008effdd14a57bc2e6081bc6ffd7a71210f05d901ecd669cfbcc239"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1161/nuon_linux_arm"
    sha256 "6804b622ab040b59a0164405b5dbd2ed9f2fd4d5bf0409399693fb7495541627"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1161/nuon_linux_arm64"
    sha256 "9cd85ef266ca8eafab4f94cfc4f86106b6a3194ed387a3a92b00a5837b2a4fff"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1161/nuon-lsp_darwin_amd64"
      sha256 "14c7682f4ffc5edc9f5ed42251b8963bfbeda9e2c7563137aaf205c2de18724b"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1161/nuon-lsp_darwin_arm64"
      sha256 "dc88f853179d53cc0b125196ce7d6dfda8ac249e0ba6bdafa7801f4e6071b7c9"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1161/nuon-lsp_linux_amd64"
      sha256 "4b761883f3cec39da1d4373663ee03aa08d4a5c11615b5341cffc69d430f5bb4"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1161/nuon-lsp_linux_arm"
      sha256 "dfe9359293a17c9cebd078118d1d96b61f5594eaf55cbad2d1c909456ac2e5c8"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1161/nuon-lsp_linux_arm64"
      sha256 "fa14fb9dda0d3ef46eafb326d0d692ba1ed2bed69fa641a57c45d74fb98c1ebf"
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

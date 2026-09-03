class NuonAT0191162 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1162"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1162/nuon_darwin_amd64"
    sha256 "b48b885850967e82c5b72485cbea665504ee27b7cca56fb0112656a6281a5b6b"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1162/nuon_darwin_arm64"
    sha256 "3a55bda503ec18203bb7af9e1e0941c847a8f2334e81405c6d575141fefb5a89"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1162/nuon_linux_amd64"
    sha256 "7fb609e7df91d0824631fd7f9ba8fd81a31af4988c0010aa3b8b625ff86c5f3f"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1162/nuon_linux_arm"
    sha256 "d8b27ffc42d60ae205bd7b8ce54f3aa652b7ec429f697d0c9e9dd205dc386e5d"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1162/nuon_linux_arm64"
    sha256 "d665e96e5af1637abae6509a0d5f0387a76b4c9601a5ee5595d82c4e07bf24d8"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1162/nuon-lsp_darwin_amd64"
      sha256 "14c7682f4ffc5edc9f5ed42251b8963bfbeda9e2c7563137aaf205c2de18724b"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1162/nuon-lsp_darwin_arm64"
      sha256 "dc88f853179d53cc0b125196ce7d6dfda8ac249e0ba6bdafa7801f4e6071b7c9"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1162/nuon-lsp_linux_amd64"
      sha256 "4b761883f3cec39da1d4373663ee03aa08d4a5c11615b5341cffc69d430f5bb4"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1162/nuon-lsp_linux_arm"
      sha256 "dfe9359293a17c9cebd078118d1d96b61f5594eaf55cbad2d1c909456ac2e5c8"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1162/nuon-lsp_linux_arm64"
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

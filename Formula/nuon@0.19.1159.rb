class NuonAT0191159 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1159"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1159/nuon_darwin_amd64"
    sha256 "491c55c515d29e35e8cce5acd3fc8457ae303bf72ebb702802371785f1569ddf"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1159/nuon_darwin_arm64"
    sha256 "df0d3ec3296276c44f46c2341449af542e536841ae701d9a9ebb1a6e03386232"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1159/nuon_linux_amd64"
    sha256 "dd04772e32ce5a7c9aa26128e6f27ca30b4fa72716983cee655df32a73245ff9"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1159/nuon_linux_arm"
    sha256 "5d0d698d726feba99cd97fea0782a445a9212b8000ce9a22b7789d438bd43f0d"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1159/nuon_linux_arm64"
    sha256 "2c0a7e14a19350197d25429f57fe055fb7acaa47e07ba0782f66f1d67bb356fa"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1159/nuon-lsp_darwin_amd64"
      sha256 "14c7682f4ffc5edc9f5ed42251b8963bfbeda9e2c7563137aaf205c2de18724b"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1159/nuon-lsp_darwin_arm64"
      sha256 "dc88f853179d53cc0b125196ce7d6dfda8ac249e0ba6bdafa7801f4e6071b7c9"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1159/nuon-lsp_linux_amd64"
      sha256 "4b761883f3cec39da1d4373663ee03aa08d4a5c11615b5341cffc69d430f5bb4"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1159/nuon-lsp_linux_arm"
      sha256 "dfe9359293a17c9cebd078118d1d96b61f5594eaf55cbad2d1c909456ac2e5c8"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1159/nuon-lsp_linux_arm64"
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

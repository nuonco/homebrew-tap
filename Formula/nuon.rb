class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.927"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.927/nuon_darwin_amd64"
    sha256 "e9b5bf449f45d6e1c9aee96d806430b477716cf4f733cf92991f9421b9bf9e9c"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.927/nuon_darwin_arm64"
    sha256 "20c528fa139e6fd9358f476fe001d15d6b33fc12c053554ad4f8749ea6353aa8"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.927/nuon_linux_amd64"
    sha256 "07cec0a5f33d98f5c3fde3d7d6d25981a82b5e0f774438887e63d4c26148d2ef"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.927/nuon_linux_arm"
    sha256 "6803ae95e3fb58f4d34cd172d45b00960ed5850497d881016c6fc7d0bcfb76c7"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.927/nuon_linux_arm64"
    sha256 "a671224043f109e95a4c232da90af743e16a480604d6c54c0a3971725cdd59f7"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.927/nuon-lsp_darwin_amd64"
      sha256 "cc67bb437922518de53ea374a42a1c10dd6c282f2e2b16ba95a0eace03164bac"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.927/nuon-lsp_darwin_arm64"
      sha256 "c0ceeadfbf91a1b896bf07a64cc13a3f94390f6e0c2c057d2b18703124fad051"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.927/nuon-lsp_linux_amd64"
      sha256 "cc66bd00197f0518f9497f832d4d95de3b476e7c8ffcccd6b80cd7b73302f992"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.927/nuon-lsp_linux_arm"
      sha256 "121d8f29e9a4ea08527d8aaaf8bc6dbde2728561ebfaf57c94d750d57a09f831"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.927/nuon-lsp_linux_arm64"
      sha256 "8e9a41077a1ae7ec72cee466ff45ff164b4752315addd90733e55e3eb1966863"
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

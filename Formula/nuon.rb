class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.765"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.765/nuon_darwin_amd64"
    sha256 "430966a53cfd0076bdb814e198f574632929ba1229d14b686c8514b214471d1b"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.765/nuon_darwin_arm64"
    sha256 "869a4fdd8e7f777985c7ad47f70036f5538a0055ca610a6e72822dfa074abf40"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.765/nuon_linux_amd64"
    sha256 "92e3d20aca85e8d65c7c6cbe06786b3d5b1a725c9a59036c35d081b6d8f354d1"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.765/nuon_linux_arm"
    sha256 "1d13a6002772e7d44e9a44277d0f8a8cb4643cd87da8db8ec786cd6a4068b361"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.765/nuon_linux_arm64"
    sha256 "d783c8fb673ea84220ed412bcdd2b30f20c6b9a564a07e74bf4c2a392beb23c1"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.765/nuon-lsp_darwin_amd64"
      sha256 "d768e62610cc768683a6e622399ab7a83b294a981504a237ebc9d06aa065aaab"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.765/nuon-lsp_darwin_arm64"
      sha256 "76769f218f7fa582fd7baeb87e372c5240b477c7b1c0aee91d1213f260fd5cc2"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.765/nuon-lsp_linux_amd64"
      sha256 "3a11f6642eec0d87ef4b4e0caab7d1dd1ce5892552c15151457e02b0ebf4e9cc"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.765/nuon-lsp_linux_arm"
      sha256 "af5ed4dd3d9d35927bd76e91a1b9b33f1648b336fd71d0cf75a9da8d1c62d985"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.765/nuon-lsp_linux_arm64"
      sha256 "20de48b2226f16f57b125079596aaaffee96c3001f2b0715dc0982faaff6b881"
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

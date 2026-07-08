class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1047"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1047/nuon_darwin_amd64"
    sha256 "07e8bccca1de243d6a9366345e4abbb5a2d2758c6de931c20f45eb7c3ad8201d"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1047/nuon_darwin_arm64"
    sha256 "42fb9450de16066f0236a8c06d02eaff66f27d118b83804ef26b5bb225ec743d"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1047/nuon_linux_amd64"
    sha256 "a1cc42a90dd97c262c0b55312a8d220b13517d6fff5db53a5cbd7e2ec3ebd5ed"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1047/nuon_linux_arm"
    sha256 "184ddaaec30df4b421ad24c6228244e237f53c65a3a8b581f0ccbb6b7e42b901"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1047/nuon_linux_arm64"
    sha256 "809d5cab899fc28803d68e1c094d72e2b71ea0b8d9f52ead6a2949573a2262c5"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1047/nuon-lsp_darwin_amd64"
      sha256 "1c42e5b197a4e01d372e99fa6a680db467c2298636e5a4be7e550a2b19e2325d"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1047/nuon-lsp_darwin_arm64"
      sha256 "cdd05da9fd27a82dc0585d2ecf68537fcc237a3a302caa73b401ff01e9681164"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1047/nuon-lsp_linux_amd64"
      sha256 "23a0a2cc61e0bf9eb0f91a6644361ec432ceff215077eb09bb64ede021689ac8"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1047/nuon-lsp_linux_arm"
      sha256 "25c09e3fde4383645191df7db16785191dc22b9904ec845ddea792bfbd5e42e0"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1047/nuon-lsp_linux_arm64"
      sha256 "7d77f4a275fd34cdfe278f0081212b11d939629e644b0e9fe5b72ba9c262b144"
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

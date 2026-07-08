class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1044"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1044/nuon_darwin_amd64"
    sha256 "41f73b60310fff078b56ee1bcc699b45eac0d9eb2ce4c26633a08f2e8c271315"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1044/nuon_darwin_arm64"
    sha256 "ebec0d343bda47ba552dbe14622596af0ebb8fd346bbdfcfd987e8217ae625fd"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1044/nuon_linux_amd64"
    sha256 "fd7a0e0c2b8db5279d3e227fee95e9d734097bb022c77885267f2e6e3cb92939"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1044/nuon_linux_arm"
    sha256 "49a312a4652725eae1dd319b455e7186b79f4f8f96bb33fa152ffb000e09b654"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1044/nuon_linux_arm64"
    sha256 "9d59e830baf862074cb6bbb698b1b65c5235f88af094c84703226a261afe928d"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1044/nuon-lsp_darwin_amd64"
      sha256 "1c42e5b197a4e01d372e99fa6a680db467c2298636e5a4be7e550a2b19e2325d"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1044/nuon-lsp_darwin_arm64"
      sha256 "cdd05da9fd27a82dc0585d2ecf68537fcc237a3a302caa73b401ff01e9681164"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1044/nuon-lsp_linux_amd64"
      sha256 "23a0a2cc61e0bf9eb0f91a6644361ec432ceff215077eb09bb64ede021689ac8"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1044/nuon-lsp_linux_arm"
      sha256 "25c09e3fde4383645191df7db16785191dc22b9904ec845ddea792bfbd5e42e0"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1044/nuon-lsp_linux_arm64"
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

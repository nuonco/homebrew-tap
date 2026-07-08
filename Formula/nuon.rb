class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1045"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1045/nuon_darwin_amd64"
    sha256 "65f054fa6e57debbfed253d4c917443098469d1fbc12aa7d8fc17e6d0dfd5578"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1045/nuon_darwin_arm64"
    sha256 "571bec0f8e4d1038fea785b3507d6cd85e94e1bf33a45bda567ce57d797f2f48"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1045/nuon_linux_amd64"
    sha256 "e1ebd836d25694d3f9575c95c882bac6cf86901112167662d3ea1944faf86b70"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1045/nuon_linux_arm"
    sha256 "f6011741c9f8ba21fb6ec92543c8ff808ff8e91f5174c55e69d7a5f3d55b6965"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1045/nuon_linux_arm64"
    sha256 "3c0c436f7105684ec56627816b9b462afb1f1a2c311150a6087657cd52d1c1e1"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1045/nuon-lsp_darwin_amd64"
      sha256 "1c42e5b197a4e01d372e99fa6a680db467c2298636e5a4be7e550a2b19e2325d"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1045/nuon-lsp_darwin_arm64"
      sha256 "cdd05da9fd27a82dc0585d2ecf68537fcc237a3a302caa73b401ff01e9681164"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1045/nuon-lsp_linux_amd64"
      sha256 "23a0a2cc61e0bf9eb0f91a6644361ec432ceff215077eb09bb64ede021689ac8"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1045/nuon-lsp_linux_arm"
      sha256 "25c09e3fde4383645191df7db16785191dc22b9904ec845ddea792bfbd5e42e0"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1045/nuon-lsp_linux_arm64"
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

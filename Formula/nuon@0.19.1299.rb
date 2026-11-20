class NuonAT0191299 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1299"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1299/nuon_darwin_amd64"
    sha256 "7a555c625117226caf0b4411558fa0a4b15825a35f5509f9fe5723963c2f0f39"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1299/nuon_darwin_arm64"
    sha256 "2d91de57405b6c4556319806de707b36e0d2bf1713f5a3283a0fc389a40c9871"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1299/nuon_linux_amd64"
    sha256 "a25a1ec1c97333b66d89d2ee3bdf39b9ef89440e6b4c778115f494636e50a3fb"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1299/nuon_linux_arm"
    sha256 "80336ffafa5f4515b3da79febdb28ad1a60d599772c8a125205172c6e811085a"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1299/nuon_linux_arm64"
    sha256 "c29d40627cfc3ac350c58bea47b641c4a4b42b3496aa234d425b02a5b4d052d2"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1299/nuon-lsp_darwin_amd64"
      sha256 "87b70fcbe25a5f1ed6235ce1977c2975c8a1683f0efe14ec0070fc8dd3986597"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1299/nuon-lsp_darwin_arm64"
      sha256 "37801f793f97cf8b63a1d20ccc4cbae9e27660251cc4115a85f9da30fc395fc2"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1299/nuon-lsp_linux_amd64"
      sha256 "b797986025d31b26984a4b4cc0679f1c652b1faf4fa4590a354af16b8dca06cd"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1299/nuon-lsp_linux_arm"
      sha256 "f318187ea6aceead73d2304f3800da7438c8384b431386f65e631ad959a3810b"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1299/nuon-lsp_linux_arm64"
      sha256 "efbe5a2b45978afe51993c86a830c97a941ab93f4b114b4ce2e6cec630ad2b22"
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

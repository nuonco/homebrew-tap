class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1300"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1300/nuon_darwin_amd64"
    sha256 "eb8be11d46150fca1017deae5a867b511ee2333c3c40b6f84519e1bf8385324a"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1300/nuon_darwin_arm64"
    sha256 "460e366ba72d8ae79ca3e0acaa0075679a2bba0cd6b8e7e57e395684f1aa1ad7"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1300/nuon_linux_amd64"
    sha256 "ef1de0e20e9b3073d019cdb80629c3064a2cb6ce69a357642a2b3cb9e687d857"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1300/nuon_linux_arm"
    sha256 "1bba8d91d38d9292f216d67864b0e9892d340a97191910b33351369b6321a22f"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1300/nuon_linux_arm64"
    sha256 "81832f9edab80ab752d281620b121170b72a0f52f0354ac5ae38411c4ea9d883"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1300/nuon-lsp_darwin_amd64"
      sha256 "87b70fcbe25a5f1ed6235ce1977c2975c8a1683f0efe14ec0070fc8dd3986597"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1300/nuon-lsp_darwin_arm64"
      sha256 "37801f793f97cf8b63a1d20ccc4cbae9e27660251cc4115a85f9da30fc395fc2"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1300/nuon-lsp_linux_amd64"
      sha256 "b797986025d31b26984a4b4cc0679f1c652b1faf4fa4590a354af16b8dca06cd"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1300/nuon-lsp_linux_arm"
      sha256 "f318187ea6aceead73d2304f3800da7438c8384b431386f65e631ad959a3810b"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1300/nuon-lsp_linux_arm64"
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

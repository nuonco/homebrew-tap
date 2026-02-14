class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.786"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.786/nuon_darwin_amd64"
    sha256 "ce66630f67cc53546162cb50024ec75a021148e606d6ee6c53a769456282f3b1"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.786/nuon_darwin_arm64"
    sha256 "b848082e3055d45ed54f1458ce1dac7917900c80ab757e3c5ceccf1a140ac369"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.786/nuon_linux_amd64"
    sha256 "96d70310d21144b185fd9c10092e9ff3811bc6f45efa29367ce22ba7f1394dc8"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.786/nuon_linux_arm"
    sha256 "1167743fb3701e49fd671f8319b8a10d68e6019228c681f8d42df2e64f2e2123"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.786/nuon_linux_arm64"
    sha256 "07b6463c27d7c4844b7026d2df9437404a2ef33c9a22f03c4ef0e264c1b4e025"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.786/nuon-lsp_darwin_amd64"
      sha256 "d2e872d07f76a0e1a5293b12c917821519444ff9e8a76de3d087a40d871781b9"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.786/nuon-lsp_darwin_arm64"
      sha256 "4df975fd7fde660e6a244e7958748f7d4df3c346d3e33e0413527609cc43ab86"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.786/nuon-lsp_linux_amd64"
      sha256 "bb90eb1914de04fdd9121da7fab82522566ddc7d47c97d364e338fb8ab3f1777"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.786/nuon-lsp_linux_arm"
      sha256 "8e583dac42511393f27406ff2fff5e3df157a86b80b385ccc6bdeee8ef6bf653"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.786/nuon-lsp_linux_arm64"
      sha256 "bdf39b5182720bef47e465c89928e04764220ed9cabf703aad76727e812efe89"
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

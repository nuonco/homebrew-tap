class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.953"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.953/nuon_darwin_amd64"
    sha256 "e88c2a428ec584bf116be08d7d81751d2d003264ea4cb51be903ac08166f1e74"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.953/nuon_darwin_arm64"
    sha256 "d58bfec6cd1dd9ec58fbfba49bf1dfa85d4c0e2eac12e92aa2a30596585b9572"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.953/nuon_linux_amd64"
    sha256 "9f52d9d410f74ebb64d818ec05dd0a87f9257c1079cf5db3657e34b00fdadd74"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.953/nuon_linux_arm"
    sha256 "2693782d46c4a63a2ff9a1ce3f3cb9b34e12f67ed44e4c400e72a9e214089655"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.953/nuon_linux_arm64"
    sha256 "035cab95323e2a0bc1b382e355227eccef776633296066f8200d1a1804c64618"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.953/nuon-lsp_darwin_amd64"
      sha256 "0c5aaaa4fd779acf54cfc98b734aebd2c44b8ad3ac23a1936ee8db2096d0ebd8"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.953/nuon-lsp_darwin_arm64"
      sha256 "15889ca4311cd73e4c1f0ded3a43c3deb5b637f78ea26ac64de01df401de4496"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.953/nuon-lsp_linux_amd64"
      sha256 "cf4702218e91b9f6b86bd514fc45772e9a6858427357635c8c29f40c002b3cea"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.953/nuon-lsp_linux_arm"
      sha256 "ce99cc03eb0595cc2de5def48d72fc12de13025b1b97f40743c43d506a5df41e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.953/nuon-lsp_linux_arm64"
      sha256 "9a0a14df42a573309f4f2e6ff5a981ada07cd5760f164cbfd5ea1f6218a41371"
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

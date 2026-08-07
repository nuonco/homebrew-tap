class NuonAT0191113 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1113"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1113/nuon_darwin_amd64"
    sha256 "bf6cccd563f93e9e3ef98df189f015a1d1f49c8127c1a43d781b0f76367383e4"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1113/nuon_darwin_arm64"
    sha256 "340257e61f78de66c14b232323023a1be70a95a873723475f2fdddfdb4d979bb"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1113/nuon_linux_amd64"
    sha256 "38f5a8587838a9d06b20e1b079f7d3ba9b891cf6cb93cf7501ac228a981c43bd"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1113/nuon_linux_arm"
    sha256 "2642bb9e70039d6b844241992dfe0e40ac7d343bb37de4a1e525c80e8d7e0a41"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1113/nuon_linux_arm64"
    sha256 "745b8837af104ad89428923fbc26865167da07717c549c3df78a16d99b2f0cf4"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1113/nuon-lsp_darwin_amd64"
      sha256 "7b8e52bc2290d0b3ac86e1a3110699fe70d843f334f791f58130d8742e33ea2d"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1113/nuon-lsp_darwin_arm64"
      sha256 "b4412224b5d117622e25978c3ce172cf424fc2d5eacf8d1964e9e69f40b4f534"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1113/nuon-lsp_linux_amd64"
      sha256 "7ae79fc836dc847a13072e4bf4e5b162b2354b488b62c7aebd0637a3b80d9d97"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1113/nuon-lsp_linux_arm"
      sha256 "576fe6b311b5b2330d752388b93ed63226e966076bf9867651069da53280a769"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1113/nuon-lsp_linux_arm64"
      sha256 "ff40f56346950252dac7ae960364f3b5e9df156ea23255e6661cedd54f391657"
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

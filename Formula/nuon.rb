class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1000"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1000/nuon_darwin_amd64"
    sha256 "2f29eafa2a5184ae96764d57cb0a76e90ed9f42cb56c16efc297dc8917d56ccd"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1000/nuon_darwin_arm64"
    sha256 "af1f595ed70e616f521cebe4762ab72725b10c7e50586206464885eb0185dc24"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1000/nuon_linux_amd64"
    sha256 "5b1a0654121e1dcb3682a5cc881b3358f570f0c9be648d5ef879eccd51db6239"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1000/nuon_linux_arm"
    sha256 "891ab30b490cd35b601febb71b2de930d8eb9a9ce4cc01e2b616180c2f94002e"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1000/nuon_linux_arm64"
    sha256 "bbc535c375634adcf239addf829852e522ed35261a6bff85fa6d527644d38cdf"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1000/nuon-lsp_darwin_amd64"
      sha256 "b0601ead51aee96a5dfe0bd4f822d00e209b51f29aa814cdef573c9392c0e267"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1000/nuon-lsp_darwin_arm64"
      sha256 "89771394e3707d3bce82d929da4730a093a7867e687baa015a261ce5b88b50ee"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1000/nuon-lsp_linux_amd64"
      sha256 "2b4ce6a035ca02a52a5a57fa72ff456a93b185da293edf006781302d5a50c328"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1000/nuon-lsp_linux_arm"
      sha256 "a04209b38dcef7db9cbc2275555cb83fec41e6676bdf3c5fce184c729247af34"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1000/nuon-lsp_linux_arm64"
      sha256 "97fd8e3c2dd350cf365df19fe11e7d85d258818f325b2db445e8be63c24133af"
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

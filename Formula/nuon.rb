class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1001"

  bottle do
    root_url "https://github.com/nuonco/homebrew-tap/releases/download/bottles-0.19.1001"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "5458a259f253cc659bf45aecaec1657af0784b450df516dc3b09aaee0a3c2d1d"
    sha256 cellar: :any_skip_relocation, big_sur:       "95201139a39f89c15a11422e4da694441887021b7e6d6ae4de872b777a89be7e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "d44f7fcd057241c671b350257494e2f742f9e63bae3f5e7afb631a5101645d6d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "9ad30904d0e018894015255137ba7ca9c46e1ae08188796624cb492e924457b5"
  end

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1001/nuon_darwin_amd64"
    sha256 "133fad14792a1cc42775f1cc7ee252db5f6b84ac4e93abca1f5e1de8b6715b97"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1001/nuon_darwin_arm64"
    sha256 "c046cea3b6f3381a42b1e8da4562b895cd29563136d29a82cb810baa5d5602fa"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1001/nuon_linux_amd64"
    sha256 "529a1cfbd26c3a8e4810a6959c3be1a2924f17349a483f4314079e3758fd4d67"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1001/nuon_linux_arm"
    sha256 "fb9706de2d7acd844a11fe8577730cf388f92c809d81ff4c1c2632ca9839c181"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1001/nuon_linux_arm64"
    sha256 "827d34008b1c008056d0169dfa9b83a6df6ecae2b09483fa42af2d126857a6c1"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1001/nuon-lsp_darwin_amd64"
      sha256 "b0601ead51aee96a5dfe0bd4f822d00e209b51f29aa814cdef573c9392c0e267"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1001/nuon-lsp_darwin_arm64"
      sha256 "89771394e3707d3bce82d929da4730a093a7867e687baa015a261ce5b88b50ee"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1001/nuon-lsp_linux_amd64"
      sha256 "2b4ce6a035ca02a52a5a57fa72ff456a93b185da293edf006781302d5a50c328"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1001/nuon-lsp_linux_arm"
      sha256 "a04209b38dcef7db9cbc2275555cb83fec41e6676bdf3c5fce184c729247af34"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1001/nuon-lsp_linux_arm64"
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

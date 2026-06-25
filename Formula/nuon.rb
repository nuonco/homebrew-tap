class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1017"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1017/nuon_darwin_amd64"
    sha256 "a3939a4de7ec6de6387b772a952970fad5f13987a9635a786dc82fe8edf6dc7d"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1017/nuon_darwin_arm64"
    sha256 "f1dbb5b6b889c129b545a711eaa2306a340fe630b23f541ada3e434d55607241"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1017/nuon_linux_amd64"
    sha256 "2a8f197abef598b66b1ab8e4e0eeb99daa263899982b4dfc0111f3ab3860fd1b"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1017/nuon_linux_arm"
    sha256 "0dc11abb700fc96067f33a7f5abd96dc84ac7b263aa2cc966659a133b71b4943"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1017/nuon_linux_arm64"
    sha256 "64dc008936f5498537fe2df2f75ba388d12087e9d2814ea885800f7a964a1b18"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1017/nuon-lsp_darwin_amd64"
      sha256 "54319fd79b8be5f0a922bd6db6fc6041f043662c795543ceb9d7e367a016142b"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1017/nuon-lsp_darwin_arm64"
      sha256 "b9f61723f9d7f1712d2d364535fd8978972f2b55d63087a20b963e9140e2ad80"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1017/nuon-lsp_linux_amd64"
      sha256 "47376e0bc160604e86775363ff38886318a775243ba5633f11658bbfb9d5d118"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1017/nuon-lsp_linux_arm"
      sha256 "fde03453b3f68f580d0af11143198b802f41106e29bbac6a98f6c612e6a87aea"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1017/nuon-lsp_linux_arm64"
      sha256 "91d6357879edb06ef920b3daa9d7aa9272d9e535f0daa5ddd071dbc3d197f5c9"
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

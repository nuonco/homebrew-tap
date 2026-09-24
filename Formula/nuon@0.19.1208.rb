class NuonAT0191208 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1208"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1208/nuon_darwin_amd64"
    sha256 "3b375e78bdb297684bfd6b95868733165acaf8c3777be006e4e1aac00d1c4f80"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1208/nuon_darwin_arm64"
    sha256 "6d07ce31b1bbccaadea002f99baf9494fd8e90be2de66dd2bd773c568d52fbfe"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1208/nuon_linux_amd64"
    sha256 "b5af31b6e2d65ac6e394bb0a633889fcb7f493d102bb36137f153e9abb0b8d73"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1208/nuon_linux_arm"
    sha256 "1fa9f3fa004d55fef0b76039f4105c443584a7f543889ebf25e2312d2ae88ae4"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1208/nuon_linux_arm64"
    sha256 "2b4aa9a2c95fda7cbd6f8df0598655795cdeee461c9c711581fec11efaa82e2a"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1208/nuon-lsp_darwin_amd64"
      sha256 "bd035a81862fc22925c55094577082f78769ebef31a8acfedba4582a4d2f579a"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1208/nuon-lsp_darwin_arm64"
      sha256 "b7b58c0d7f81f9929c8fca8be84a7546a693090e1545f99791fdeafa5c0871b4"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1208/nuon-lsp_linux_amd64"
      sha256 "3f20edf9898988d1832c44de98c4b3a7abceaf585ef316ead80e2ffe13c24ad4"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1208/nuon-lsp_linux_arm"
      sha256 "c815abacd3061cc190def81098b4899bfe08698e1cd3e2111992b477fc58a7aa"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1208/nuon-lsp_linux_arm64"
      sha256 "45a2111048f87e0ad2aa02e8e9e337298ddc0bc96a32d3b89afce20d8f7494fa"
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

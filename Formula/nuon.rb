class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1014"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1014/nuon_darwin_amd64"
    sha256 "0c55aa57f1ac8d19282ad496337fe277ea6b82886a9fb29d768392d9b8a37612"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1014/nuon_darwin_arm64"
    sha256 "5555c548eb55a3dc8fbe2481ce6daa2851da035cfdab6edcd581e2c08b8bd5a7"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1014/nuon_linux_amd64"
    sha256 "fdfba17f6e139e70999e8604c4c19012ed06c0c929c8a406a094ba32a97ea3c3"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1014/nuon_linux_arm"
    sha256 "8b9f02be3208b26aed576c2bc060b618537ee581f68660bd4f95a4ad7ff4bc40"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1014/nuon_linux_arm64"
    sha256 "99c2140095ea4b863f12b0df542dc94e057eedb179935f5b406858f21614f7b0"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1014/nuon-lsp_darwin_amd64"
      sha256 "5c0913885c3c5fb247febc0ee3b488ad0e22e288725f62d96b6d2c4099b0e0d6"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1014/nuon-lsp_darwin_arm64"
      sha256 "c8a438d6a2bb3ac17d184d6e75f018a29720adffb4ad9b08309594073a1398cc"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1014/nuon-lsp_linux_amd64"
      sha256 "ff5dc9a8dff99548850cc40164b25a3820f08422f0b4c138767dfd27d804bba8"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1014/nuon-lsp_linux_arm"
      sha256 "a2b810fd4fad510d1e6aa84da2accebdabd20be9794d610805136bfff8497dc9"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1014/nuon-lsp_linux_arm64"
      sha256 "79b2ecb70bc1b7f4b550b5bf215e799a25c248ea0b4b9f79265771b0fd625a53"
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

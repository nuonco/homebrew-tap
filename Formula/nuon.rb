class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.793"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.793/nuon_darwin_amd64"
    sha256 "cef90f2cccf772ed319fdbdaa0ede5621cba2a6b87f29e76a7b319dbdecce1f9"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.793/nuon_darwin_arm64"
    sha256 "4d759a8237a92869dd7dfb06e4ad3498332eb4e10bd22ab3f6a0df82aa443405"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.793/nuon_linux_amd64"
    sha256 "5a0d9d0c1c32c6695ac0084f4203d41529b7de3f928422c7affc9b34dbf1cd50"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.793/nuon_linux_arm"
    sha256 "5d9f5e6ee8b2ab947254cfb2c8db28245605be834060c68e977d4f9a84dbf203"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.793/nuon_linux_arm64"
    sha256 "bb11cb0dc2a7399d631556ec20aed31b8fb94bac3aaf5ed62306c77271afccae"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.793/nuon-lsp_darwin_amd64"
      sha256 "c9e4b6e7ce6014df76559051534c09005b6166055ce61971505a366994c0a235"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.793/nuon-lsp_darwin_arm64"
      sha256 "2645d7cd6e223e8511d5a2e1fa5a6ba5459f4acc2005e322179376cfe6494dd9"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.793/nuon-lsp_linux_amd64"
      sha256 "577e350fd2d394707d5b6db1a2de31ac4dfe320bf0e71850200d1c25f1846c55"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.793/nuon-lsp_linux_arm"
      sha256 "bfba202455f3fad78ba4cff1130e5884dfa5897805caaea133517cf1b0bb259e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.793/nuon-lsp_linux_arm64"
      sha256 "a9050e55e49b2b2d971b67c05672678c7e8993b0571f3eed69f27e63d45055c8"
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

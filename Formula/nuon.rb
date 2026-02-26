class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.809"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.809/nuon_darwin_amd64"
    sha256 "4fc4485063d63204b3cda8a59e2617ce90966feb609bd80ad6d04004dad9c915"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.809/nuon_darwin_arm64"
    sha256 "9408f38bb3a8eceffe1e4f33b5475e06688ba3fa109d513f09def81f7cb3bbfc"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.809/nuon_linux_amd64"
    sha256 "944c2292ab5db029577045f8aacff2039e11c14b294754fb5b05b1f0c359ad3a"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.809/nuon_linux_arm"
    sha256 "31b047d2d213c7555ae1c6abfbceceea3ba7a7e32257bb7ebffea49cd567dc87"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.809/nuon_linux_arm64"
    sha256 "cfa0a5aed03990fc63f1b313a179731cd0155d3c4a84502a9995132be16cb1d6"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.809/nuon-lsp_darwin_amd64"
      sha256 "345a270b2a72fa56e636e4d4eb727c5aceb059e22cbde3ad4116e1149ff6b34c"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.809/nuon-lsp_darwin_arm64"
      sha256 "5daef6c226d0cda5ceecf72591437848050b71c78b7dd3d037a1355d0d60109b"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.809/nuon-lsp_linux_amd64"
      sha256 "8a1403bc7607be5fbe0c47e6a27f7fa10c92dbff1cf03f095ac1708e2a9eb228"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.809/nuon-lsp_linux_arm"
      sha256 "eef230d493c99e737b7870a7c39da7fd12add166551bf7cc272293dc286a6f6f"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.809/nuon-lsp_linux_arm64"
      sha256 "571d193843ae4f33899e0bec3ab38d956e51a242153e2c442bca87d0f9b0414b"
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

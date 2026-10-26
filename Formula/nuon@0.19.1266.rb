class NuonAT0191266 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1266"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1266/nuon_darwin_amd64"
    sha256 "0f841ca2a2d3e45a7b8b5e92f20e43addb81545d638d1e5661cbfeb1aee23b91"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1266/nuon_darwin_arm64"
    sha256 "46c7846c916ab639e2cfd8a043538accfbd7df1db7ff9fa2fa7a4eef93b07914"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1266/nuon_linux_amd64"
    sha256 "86bf0dd54536e92d02b583e33c4ad21dae4e3106e58ffd934ee21fd97e1d7000"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1266/nuon_linux_arm"
    sha256 "d3d851fc7b8231c7e494b5129af2375cc7bbde7fc8733bbb8bc228d3998b3b33"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1266/nuon_linux_arm64"
    sha256 "62249799158e59d548c602cb04e22f2f43f3290f2dda5866c979a0b6f6e80faa"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1266/nuon-lsp_darwin_amd64"
      sha256 "d0c8adfec317418ead479f02d34ff25f8587a5c2c689ea8ef0b1c8ab9e2a3728"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1266/nuon-lsp_darwin_arm64"
      sha256 "78131eb8cecd23100707b74a4d2586aa68ccc8a5b6224a31bc6a75c1b4c3f485"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1266/nuon-lsp_linux_amd64"
      sha256 "d4a17b592f4dda1334baf7f7f2a750cc5eb8909456b5b2a79a1db7ca007433f7"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1266/nuon-lsp_linux_arm"
      sha256 "eed000c44fbc87ea396f89644b36b7a28b5397cdc535b726b64337cc3477c26d"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1266/nuon-lsp_linux_arm64"
      sha256 "6d2b192e4a54405d1c590c7dd0dbb38cc3a631deda974d33bbc44569117c36a8"
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

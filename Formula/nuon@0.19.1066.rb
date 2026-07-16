class NuonAT0191066 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1066"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1066/nuon_darwin_amd64"
    sha256 "f0f213a8ece5ed400372eb54e003c961e3bc962bed55295721e405369aad4930"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1066/nuon_darwin_arm64"
    sha256 "520521e529f624af8b9b581a7b841cf316f1207c297b06a96394e25e505ffbb8"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1066/nuon_linux_amd64"
    sha256 "1307f012e3d181b9cfc60d60d8cc0f8b9d3e4f6cc4c9d7801b5c363215f75ccb"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1066/nuon_linux_arm"
    sha256 "51de44fb6ce4aade2f6989c6ef1471509501747ffe48a0e7c23c80590f913b24"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1066/nuon_linux_arm64"
    sha256 "d0d42d659421be2b7a454164d44cbbbec4467f9b471b6e43cb781b5765168b24"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1066/nuon-lsp_darwin_amd64"
      sha256 "fafe885fca8f29c9b157e119d5f8a9dca694c4abd35ada5f9a7e4726ed950b19"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1066/nuon-lsp_darwin_arm64"
      sha256 "891a14f1001ddfdf45d7bab101050481e26419c814d03eb9ea750b7162a54e96"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1066/nuon-lsp_linux_amd64"
      sha256 "529651b46cfc13aa1a5217d8553c1d39801662e16e8dced74f7e89fe44650c51"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1066/nuon-lsp_linux_arm"
      sha256 "114838c59e8896a0bf880c1c50b76475b25234fa7664fbc3a636e84158f3e80e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1066/nuon-lsp_linux_arm64"
      sha256 "b877350c0dcb80a35a7ce3e172ac3bbb2fd8e623745dd76c6f5b887f644d1595"
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

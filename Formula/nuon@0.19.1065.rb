class NuonAT0191065 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1065"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1065/nuon_darwin_amd64"
    sha256 "804ceeaf281b8d95b323b619f4788869f747cf59209f4c586c449cd0a6dbbe0e"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1065/nuon_darwin_arm64"
    sha256 "e105e1a0bb335c2876cc8bb76ca7ca8f54808abdf68b5cc587ed2a733c162814"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1065/nuon_linux_amd64"
    sha256 "2214aeb1314f56d7a088d7df95321bf2dbd676e09c56e1d1995d03315e670954"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1065/nuon_linux_arm"
    sha256 "8dba754da1957a46251dc70de01f9b49a85dfbcb4ab2cec58f6f27cc01a57ad2"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1065/nuon_linux_arm64"
    sha256 "22d3133927c519d24976b08a049a93c6b8755c75261161ab5eba5f59704fb80a"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1065/nuon-lsp_darwin_amd64"
      sha256 "fafe885fca8f29c9b157e119d5f8a9dca694c4abd35ada5f9a7e4726ed950b19"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1065/nuon-lsp_darwin_arm64"
      sha256 "891a14f1001ddfdf45d7bab101050481e26419c814d03eb9ea750b7162a54e96"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1065/nuon-lsp_linux_amd64"
      sha256 "529651b46cfc13aa1a5217d8553c1d39801662e16e8dced74f7e89fe44650c51"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1065/nuon-lsp_linux_arm"
      sha256 "114838c59e8896a0bf880c1c50b76475b25234fa7664fbc3a636e84158f3e80e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1065/nuon-lsp_linux_arm64"
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

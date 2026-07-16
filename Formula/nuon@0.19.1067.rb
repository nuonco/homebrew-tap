class NuonAT0191067 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1067"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1067/nuon_darwin_amd64"
    sha256 "869d2186e2d1fe0708ecdc8003279ac00a1bb79451cffd2908733b89063374d8"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1067/nuon_darwin_arm64"
    sha256 "81344a8171183828a76eeb95cb73b7947d2616c9084c1c898de3ad4b5e3cd405"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1067/nuon_linux_amd64"
    sha256 "ffa7ff3f1931ad22312875ef92717729839ed0aaf70e7cbff2e5fc487290ba6a"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1067/nuon_linux_arm"
    sha256 "7eea55ca044e22e819787200559e480068142fc1d7fd35cc4488cb18c32ed9bb"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1067/nuon_linux_arm64"
    sha256 "c90d9e1c1074e9e8b4413bc0b5c60eaab3693051b3b0ebdb58a3ed5f89e562ac"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1067/nuon-lsp_darwin_amd64"
      sha256 "fafe885fca8f29c9b157e119d5f8a9dca694c4abd35ada5f9a7e4726ed950b19"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1067/nuon-lsp_darwin_arm64"
      sha256 "891a14f1001ddfdf45d7bab101050481e26419c814d03eb9ea750b7162a54e96"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1067/nuon-lsp_linux_amd64"
      sha256 "529651b46cfc13aa1a5217d8553c1d39801662e16e8dced74f7e89fe44650c51"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1067/nuon-lsp_linux_arm"
      sha256 "114838c59e8896a0bf880c1c50b76475b25234fa7664fbc3a636e84158f3e80e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1067/nuon-lsp_linux_arm64"
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

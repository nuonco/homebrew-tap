class NuonAT0191068 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1068"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1068/nuon_darwin_amd64"
    sha256 "8b0473114a1fcd814b59d39f1e66991e7e94753e77f5fa873840bf3d82852011"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1068/nuon_darwin_arm64"
    sha256 "e50c6063e4dc53cd41acb7540642dcb67d09ce57425d3f8f3acc65491449d0a1"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1068/nuon_linux_amd64"
    sha256 "70396a2e92b3351ed14d04f855afeb89052a7633d4c92cc731cb9594cc27e067"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1068/nuon_linux_arm"
    sha256 "f041060f63335c0b4f0df6c0265edc5e384599d07c7b754fed9fa48a4e45cab3"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1068/nuon_linux_arm64"
    sha256 "6ce9759d4f6634a9ace4ab2cb1cc6fa0de2f75ffb551498ae4b43a39003fe277"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1068/nuon-lsp_darwin_amd64"
      sha256 "fafe885fca8f29c9b157e119d5f8a9dca694c4abd35ada5f9a7e4726ed950b19"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1068/nuon-lsp_darwin_arm64"
      sha256 "891a14f1001ddfdf45d7bab101050481e26419c814d03eb9ea750b7162a54e96"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1068/nuon-lsp_linux_amd64"
      sha256 "529651b46cfc13aa1a5217d8553c1d39801662e16e8dced74f7e89fe44650c51"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1068/nuon-lsp_linux_arm"
      sha256 "114838c59e8896a0bf880c1c50b76475b25234fa7664fbc3a636e84158f3e80e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1068/nuon-lsp_linux_arm64"
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

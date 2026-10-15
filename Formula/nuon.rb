class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1246"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1246/nuon_darwin_amd64"
    sha256 "2c7225460795391692af296ea59f3acc7c42ed235f007baee0c28cee44b4776f"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1246/nuon_darwin_arm64"
    sha256 "1540a76497dcb8c04977b338db6bfa9413459822d464bf4568666de31f2253de"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1246/nuon_linux_amd64"
    sha256 "f9b14029ce95449d0110377eb944abbd415d3e64286da7efc25308271eb108d5"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1246/nuon_linux_arm"
    sha256 "5331d0443926f2b29e35f67f250732b8e126f4f7fb2ed26e9c184cfa6586edd5"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1246/nuon_linux_arm64"
    sha256 "0812bf281f0bc43a636a382fc29644d23fd59d2cd57bb8a2224df0a179efcde0"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1246/nuon-lsp_darwin_amd64"
      sha256 "c2992b3bc413e785f0e007439c7fac7f44667b1f544be416e794def7b9a9a263"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1246/nuon-lsp_darwin_arm64"
      sha256 "ee8bdf9c83cf9d586c895d06c2607f5dce7b2fe76ad7119a142f294d24540e62"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1246/nuon-lsp_linux_amd64"
      sha256 "fce57dbeabd771c2bdf7638fdf581b2430b35ad5002829a2930ea25e52ff955a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1246/nuon-lsp_linux_arm"
      sha256 "af09b7b43df1825d3209a2d441db5d25950f3c7e54f402aaab7121c15c4af004"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1246/nuon-lsp_linux_arm64"
      sha256 "11e6be1f5ecdd8de79d3cd45953ec0579e2cbc108f43b22aff9265642b536438"
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

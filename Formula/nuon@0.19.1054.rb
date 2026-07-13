class NuonAT0191054 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1054"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1054/nuon_darwin_amd64"
    sha256 "37b4da2a6e76b891af611f2d71c1a7de2c5ee1ac7fd2201e0e1330fbcc6433ea"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1054/nuon_darwin_arm64"
    sha256 "b9cd4d5f448de31eff1b651134fc5dc499d26f3d18afe9f12d18c79fece93495"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1054/nuon_linux_amd64"
    sha256 "80e648e07b972c6ce98efea955e1b5099d2583e2b05ad5d4dbdcea1ecc25dc14"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1054/nuon_linux_arm"
    sha256 "00b5e6acd1ec6ec913588030542fde96e52a14a3ba474aab4ed8592030f50885"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1054/nuon_linux_arm64"
    sha256 "1ec2eb46fc31f8d8420d715b5def49a0d6c765c9d94f91998247d5ec972dac29"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1054/nuon-lsp_darwin_amd64"
      sha256 "9c6bf03ee855956feb074cb42f7cf4c533f58d77407a6c1f2321b032f59a14cc"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1054/nuon-lsp_darwin_arm64"
      sha256 "ec95054c76c7e58d9af3b12b07b810e29dc5f9eff2f91991efb5fe57f8103ad4"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1054/nuon-lsp_linux_amd64"
      sha256 "a7066ea18ace26c8ded42b1ca5881f5209566271a8474407a252c024582e7c99"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1054/nuon-lsp_linux_arm"
      sha256 "ecca4c4ceb8c9589cdb23fd097d338ae8f4cfe2d0b9b743d62ec4cc401ee5dd3"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1054/nuon-lsp_linux_arm64"
      sha256 "7ccee00185d89852bacdbc4f2c90fd5083b022467d41fe3cf57fa76da4a94b62"
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

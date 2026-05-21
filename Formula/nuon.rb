class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.962"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.962/nuon_darwin_amd64"
    sha256 "bb81d583337e88bc6dd5a57db94e40151f6e0b2022a9485345e5b1a07ca8708b"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.962/nuon_darwin_arm64"
    sha256 "d8f437ee3c2b84571d8938595b6cb389988d49dab71511e581da2f73e756c936"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.962/nuon_linux_amd64"
    sha256 "ceda9e32c306163278bdcbcb7b0f6c92ce864087e0b1413e326c4ea28f13764a"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.962/nuon_linux_arm"
    sha256 "88f3f2d8c45c31beeedf940c0d50a73f86fdb90b97d5b9a9d08e37eb9c2f34f4"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.962/nuon_linux_arm64"
    sha256 "d6b4a65f095bd858c2af063a4450a5cd808a40fffb82a277ff16839af6dd185a"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.962/nuon-lsp_darwin_amd64"
      sha256 "9f4c8a7ec3cca56b3f93d27902c9a9ddfa95af4d795dac64866db9a674fd9ed6"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.962/nuon-lsp_darwin_arm64"
      sha256 "e7a255990a192284d509cc8a65058e6ba7e31c58e5a0feff4f01c2b65c9e68c3"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.962/nuon-lsp_linux_amd64"
      sha256 "2cd3cf0ce1bdfaf1ad8b99425a319f8a13176ec02c26cf38286e9912a37b95d6"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.962/nuon-lsp_linux_arm"
      sha256 "d9df610122967d7e3191d2f5d96b12fdb6922f4c76d48da6c29222fb9b563b4b"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.962/nuon-lsp_linux_arm64"
      sha256 "31e28d49bc81a6cbf256fa8e4b6989a6a31d8ba4a8c6fb4c67600669690f8e86"
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

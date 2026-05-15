class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.944"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.944/nuon_darwin_amd64"
    sha256 "9ea96b2b63e6de889561d282556d1855376c07905a88b5fa2fa8dddd1803aa8f"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.944/nuon_darwin_arm64"
    sha256 "6f7641f0ec0c7dbe5cad8f9d6217597a9b1dde2c09e8cc823fac0a106dbe21a0"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.944/nuon_linux_amd64"
    sha256 "2630ec988b020cc4c13ffff3714cf862bced41c271c4702a177a71916670082d"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.944/nuon_linux_arm"
    sha256 "911438759bca2edf6bab9767e478ec58666ba5e3c663be0871d28cdc29cea6c7"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.944/nuon_linux_arm64"
    sha256 "5a6eb6ae6c05b82a03087b45d9b51593349b4e4f1ce23d413e27a12bb9155ec6"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.944/nuon-lsp_darwin_amd64"
      sha256 "d2e34c26829320571db4c09464b2665fa5a3529b064f102c3669369e895ed84c"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.944/nuon-lsp_darwin_arm64"
      sha256 "47fb9de4d7949b669994401bbbf5a1a76b68a15f02bc62e6841814a3003333d8"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.944/nuon-lsp_linux_amd64"
      sha256 "65ab9528ae09053eb0b233d9acfa6fd256d86696a9b8cb14f641ecedec9d711f"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.944/nuon-lsp_linux_arm"
      sha256 "a586a46dff1fcad22d8a6a91ab81ac9e9c958b76fd74cc3ab797e85c6dc597bf"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.944/nuon-lsp_linux_arm64"
      sha256 "7198b48323fc2735505e2660bb90c6f23c64e7decc9a1ff23693793bcaf60146"
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

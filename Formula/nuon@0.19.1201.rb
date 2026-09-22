class NuonAT0191201 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1201"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1201/nuon_darwin_amd64"
    sha256 "fffe2cbc54c2f035bcd261706d363a1c3bbf84e8b0f343bd3ef057b4a1355a43"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1201/nuon_darwin_arm64"
    sha256 "33a8e9121c53dacc601a65d0e464e73770c34c461c2c7675a9808dd95910f914"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1201/nuon_linux_amd64"
    sha256 "ad7d36263706b99d219afd8e6319e349ed52a442d4d6a6bbef806aff3fa01b03"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1201/nuon_linux_arm"
    sha256 "d812a78e43d951e89885639a0053af600caf6bb262c0d9aaecbe4fd5a2d2ce0b"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1201/nuon_linux_arm64"
    sha256 "618f95c2cc06421a9849d7604f58d6d612580395253a52297994d8825ccc39e7"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1201/nuon-lsp_darwin_amd64"
      sha256 "223eb24a38e4c35fa281b0dfcf88fd100f2c6907895efbcb8b2e919f46b94634"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1201/nuon-lsp_darwin_arm64"
      sha256 "0de520000d7eb0e57ac5fc63e4c8549daa5704a719c64b5a8208be19e8f3e3cb"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1201/nuon-lsp_linux_amd64"
      sha256 "ebc6327e5db1338b2bc7b2dc900f5c35cc8536be8fe6c8c879f1d100944c02a7"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1201/nuon-lsp_linux_arm"
      sha256 "c56537829c2c9ce58e3e1535d1f12dc258d3e0ad61f9db26f805c38847cfce10"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1201/nuon-lsp_linux_arm64"
      sha256 "8b9332c8b7c2d9ec5bcc2d6d9f6028ca645960d0df6490d28ab647e5e0382fa7"
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

class NuonAT0191202 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1202"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1202/nuon_darwin_amd64"
    sha256 "6498f1caf48ac7b8e85a5e29def162b469cc5078828ec957c464ee397895d909"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1202/nuon_darwin_arm64"
    sha256 "f6e583c1262866ebd6af913b3110be31048e767b8498712637797222ba9b242e"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1202/nuon_linux_amd64"
    sha256 "53bfa83d82ea1eccc370b07b531ee4c1dfed81456fab5d9fe5adf81845512646"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1202/nuon_linux_arm"
    sha256 "74c61050119b4ffa635baa17fcb2fb614bb7e513ba3d47d2037dafaf26cf05be"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1202/nuon_linux_arm64"
    sha256 "5f2706a779de099038f15cf5b8aec51156b78ca7167e8da499b735b28ad1af15"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1202/nuon-lsp_darwin_amd64"
      sha256 "223eb24a38e4c35fa281b0dfcf88fd100f2c6907895efbcb8b2e919f46b94634"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1202/nuon-lsp_darwin_arm64"
      sha256 "0de520000d7eb0e57ac5fc63e4c8549daa5704a719c64b5a8208be19e8f3e3cb"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1202/nuon-lsp_linux_amd64"
      sha256 "ebc6327e5db1338b2bc7b2dc900f5c35cc8536be8fe6c8c879f1d100944c02a7"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1202/nuon-lsp_linux_arm"
      sha256 "c56537829c2c9ce58e3e1535d1f12dc258d3e0ad61f9db26f805c38847cfce10"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1202/nuon-lsp_linux_arm64"
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

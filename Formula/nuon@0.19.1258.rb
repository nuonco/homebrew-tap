class NuonAT0191258 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1258"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1258/nuon_darwin_amd64"
    sha256 "3e84a290dd8ba95b3364711f974f03a52ffed8fb4f8e4b81a71914375e1fea96"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1258/nuon_darwin_arm64"
    sha256 "d14b8b240d0186d357f39a2199ca9ad6a33a5ca9413a2924721ed0dd163c168f"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1258/nuon_linux_amd64"
    sha256 "983e3bb5b37af272df5ec67249fd618cd9a49822f13032fb8680e8bb3be42c11"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1258/nuon_linux_arm"
    sha256 "4b892e0cea32eb471dfa1161f34d70597b29a68407162cf6c21f681fb01aa243"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1258/nuon_linux_arm64"
    sha256 "e47c7f424c87ffbf25017030760d33d48c212a07ee313b196f0ff2c0c340208b"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1258/nuon-lsp_darwin_amd64"
      sha256 "108124cc57ac7c9b1a051012a43d487b0aa43a34230124614c6ab953b3aa9490"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1258/nuon-lsp_darwin_arm64"
      sha256 "6ed223adbfed6d1328d882be04d94f67b217b11a4ff679078e77d02227b19ecc"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1258/nuon-lsp_linux_amd64"
      sha256 "9aeb602642f2cbf4c1de6db9d3b4001ec24d21c6bf00a22a7b349580bca11507"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1258/nuon-lsp_linux_arm"
      sha256 "2beaaeb4df1ca88e27f83ddf82d13badf7666f73bc86a740bddabb19a629a4ff"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1258/nuon-lsp_linux_arm64"
      sha256 "840e61151528f64033af4bc1fc5d4c7c8b52b0e1634a272c9c20a51cc8ca1b62"
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

class NuonAT0191146 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1146"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1146/nuon_darwin_amd64"
    sha256 "155de66f5d38354074c59fd522cc244cc0eb5b7f334ed8018b55add5c986d82c"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1146/nuon_darwin_arm64"
    sha256 "68d338bed9ce807953ef2482b35f77b024529dd57114864dfa9f300e65cabe56"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1146/nuon_linux_amd64"
    sha256 "daeeeb200ccda3b0a6dcfd0ece79b824bc658c5d76ce66699032fd7ad631580f"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1146/nuon_linux_arm"
    sha256 "2e719cf6238ec63b99384d409745cfc35c37e11b0d1ead40c82c027374c15890"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1146/nuon_linux_arm64"
    sha256 "2944d34540242446b0ed240e231ae6cb0cae717377acc519306a023a2c9b6587"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1146/nuon-lsp_darwin_amd64"
      sha256 "be691bf27d869d95e30ab5c3f208fc65c6565e3e5121231e029e879287105ce1"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1146/nuon-lsp_darwin_arm64"
      sha256 "c9c7e227ea7110ee2ecb852e11942ad01368c31cd92a4fd9eeb9671fe06224d3"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1146/nuon-lsp_linux_amd64"
      sha256 "e791279d32a7d4420183b225b99cd58aa97095eaf62a52a1de224f2d62757fb6"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1146/nuon-lsp_linux_arm"
      sha256 "7169d985882f748ffe35e743f99ae4bdc8fa98aacdbab714364da73b3856823e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1146/nuon-lsp_linux_arm64"
      sha256 "efad13207c5f514e7d952f375b0ae5b876ba44242b20395dea2b3436e18ff4b9"
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

class NuonAT0191147 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1147"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1147/nuon_darwin_amd64"
    sha256 "b94e362913876fe751568240aea4fa51626a1463c095bda468c74cb0feec8507"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1147/nuon_darwin_arm64"
    sha256 "2c80565afa2127a91f0c81da9101fae62dd6e81ee1b19008534547fd8b75bdc6"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1147/nuon_linux_amd64"
    sha256 "017b2348450c86ebe7ff5d26af968d3ff49a64c7a5b081f2ecf4e21288c8ee52"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1147/nuon_linux_arm"
    sha256 "ee65cceb83395498df26c1a613c21b44564ed040ce14dcaad8995a4700a8783d"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1147/nuon_linux_arm64"
    sha256 "1df20c74d1d2e640504ecd8b12defa287368feae381836d0fdbc52c28fa7bb4b"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1147/nuon-lsp_darwin_amd64"
      sha256 "be691bf27d869d95e30ab5c3f208fc65c6565e3e5121231e029e879287105ce1"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1147/nuon-lsp_darwin_arm64"
      sha256 "c9c7e227ea7110ee2ecb852e11942ad01368c31cd92a4fd9eeb9671fe06224d3"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1147/nuon-lsp_linux_amd64"
      sha256 "e791279d32a7d4420183b225b99cd58aa97095eaf62a52a1de224f2d62757fb6"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1147/nuon-lsp_linux_arm"
      sha256 "7169d985882f748ffe35e743f99ae4bdc8fa98aacdbab714364da73b3856823e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1147/nuon-lsp_linux_arm64"
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

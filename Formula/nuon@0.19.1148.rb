class NuonAT0191148 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1148"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1148/nuon_darwin_amd64"
    sha256 "00621ed13dc08d97ff4d7f80f095243508ce720324ff11108d0a95efaa921415"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1148/nuon_darwin_arm64"
    sha256 "e303470e5408db76b2fc325e7fdfcb5b6f455a159632037d643b39ad619eb277"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1148/nuon_linux_amd64"
    sha256 "fa73629feabc332759b48535e254550d1640b1bbf33703349f758188fd5ce98c"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1148/nuon_linux_arm"
    sha256 "14a656681433e71941e59135e3b3b912ed3f2874c894cbfa881d2cc967ba7594"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1148/nuon_linux_arm64"
    sha256 "47a168ee0e6d51e6f2c0d4a668b73679bf8bf3cf765c2bb8a6c367350306a77f"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1148/nuon-lsp_darwin_amd64"
      sha256 "be691bf27d869d95e30ab5c3f208fc65c6565e3e5121231e029e879287105ce1"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1148/nuon-lsp_darwin_arm64"
      sha256 "c9c7e227ea7110ee2ecb852e11942ad01368c31cd92a4fd9eeb9671fe06224d3"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1148/nuon-lsp_linux_amd64"
      sha256 "e791279d32a7d4420183b225b99cd58aa97095eaf62a52a1de224f2d62757fb6"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1148/nuon-lsp_linux_arm"
      sha256 "7169d985882f748ffe35e743f99ae4bdc8fa98aacdbab714364da73b3856823e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1148/nuon-lsp_linux_arm64"
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

class NuonAT0191076 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1076"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1076/nuon_darwin_amd64"
    sha256 "45b9c6ccb162e58dd01a6877ecdeb9c771826b97b2a318e2c78f236967f96db0"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1076/nuon_darwin_arm64"
    sha256 "11e7ddaeaad15c1f04df36beb821043dd6a0a098b70f3136d968847d2770e46a"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1076/nuon_linux_amd64"
    sha256 "aa7a595d6da5ec087d02a7108b5006cb4ad50e6b3ea6a238211a266cff7a9683"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1076/nuon_linux_arm"
    sha256 "3777fa198c8df6ef97884a5bc3a66fc2f0088914432c9080d3fa72fbe83fe510"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1076/nuon_linux_arm64"
    sha256 "e5ab6d0ad03c64a23cfabfb97b8df9df245e78f2f19ca231de3a6accd0c7d0aa"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1076/nuon-lsp_darwin_amd64"
      sha256 "eb6f293f0b5742b0ef5a16295b0bf452b238626284a87b20885fa336cd53d106"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1076/nuon-lsp_darwin_arm64"
      sha256 "b91a43a02e4579fd71dc025f1757dc2a9a23fd07054fd0097f1eaa087b27c3e6"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1076/nuon-lsp_linux_amd64"
      sha256 "76adb2d082c6eac46733bd9b8aacb21fdb3a3a71e33f52ba0d8d515d6df4fd09"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1076/nuon-lsp_linux_arm"
      sha256 "26cbd55cdc1d925f034e3eeb5c839a84c354e5536672018f22285e9b6979f65e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1076/nuon-lsp_linux_arm64"
      sha256 "4f077103ec674535186f5f016b88fc5ca0e7b7ce3afc11ba27d47a33b27ba662"
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

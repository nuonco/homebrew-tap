class NuonAT0191096 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1096"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1096/nuon_darwin_amd64"
    sha256 "fac1b964cb6812c1ac2be5f078da2f7b001b703f55d27becec59d8a1b0b0dacb"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1096/nuon_darwin_arm64"
    sha256 "16e82e6fb1b11883233b4ed4ce2c166fa3c6cb1f6bab2399ce2a3f61436060e2"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1096/nuon_linux_amd64"
    sha256 "31ec306910057e51d3605e68da2ac148898de14bed77a0b1a97516b1fa428255"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1096/nuon_linux_arm"
    sha256 "70537bd65b910d2bda2a40c0d95b7afe75d9f143a2a43073f5d8c5399ca56073"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1096/nuon_linux_arm64"
    sha256 "0cdb3eae4d1f042e8b4efcc1484e1b4f0190a5dfb176710178833e8f93b40358"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1096/nuon-lsp_darwin_amd64"
      sha256 "ecc6bac29e0ab233b91819b8125e48d23fc2d6aad1a758a3f2b6724d12b130b3"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1096/nuon-lsp_darwin_arm64"
      sha256 "c5f0f6c84aa7ce41efa932fec2f28b2a7e5551a62a94003d403f391bf4c8aadd"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1096/nuon-lsp_linux_amd64"
      sha256 "e47741777d95ba1b23947558d4a722bbbb05b6311451e20b1c71ca61a681c608"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1096/nuon-lsp_linux_arm"
      sha256 "a291079fdc61c998e5bab3415dc521346f76824b62de50d61f85db58bd3b8563"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1096/nuon-lsp_linux_arm64"
      sha256 "17fd12e4f6ef622be53ad5e39c368cd5177c31de546dd8ed8948a1843d93a138"
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

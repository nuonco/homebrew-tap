class NuonAT0191097 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1097"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1097/nuon_darwin_amd64"
    sha256 "3a2d8ac63c235930101ebf08cd38b87a8ac6ad4018eda94330ab456ea4442a24"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1097/nuon_darwin_arm64"
    sha256 "aef8b74851dfacb9e2fb5a91f6a2e8fba0b46f173c5490ba98b8d8fb7d7b8428"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1097/nuon_linux_amd64"
    sha256 "23329d30e68e573d02bb57010ecf08539a43f548208b29b1ebf8732d0119a695"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1097/nuon_linux_arm"
    sha256 "71a87169069ecdc2fb3f1c6f1068143053b3f154d81aa8e6ab77de62e375994e"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1097/nuon_linux_arm64"
    sha256 "63011ef919db47f38dac9d74d5b1d43ecadfcb65d4fda16226526fd7e5ef7a00"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1097/nuon-lsp_darwin_amd64"
      sha256 "ecc6bac29e0ab233b91819b8125e48d23fc2d6aad1a758a3f2b6724d12b130b3"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1097/nuon-lsp_darwin_arm64"
      sha256 "c5f0f6c84aa7ce41efa932fec2f28b2a7e5551a62a94003d403f391bf4c8aadd"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1097/nuon-lsp_linux_amd64"
      sha256 "e47741777d95ba1b23947558d4a722bbbb05b6311451e20b1c71ca61a681c608"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1097/nuon-lsp_linux_arm"
      sha256 "a291079fdc61c998e5bab3415dc521346f76824b62de50d61f85db58bd3b8563"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1097/nuon-lsp_linux_arm64"
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

class NuonAT0191251 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1251"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1251/nuon_darwin_amd64"
    sha256 "2138d9736e18c840236b58294f1e273bfb2f3c4df8e08270925b5a8e655c0803"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1251/nuon_darwin_arm64"
    sha256 "5a33fbe0cb0e18ffd19b8d502dde97227890b22c1efca9334baa1e4a66b81afd"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1251/nuon_linux_amd64"
    sha256 "5aa43f82cf2a199acc8fb97b710d87cdc2f87bda650522a1b78170a02ee6b1f4"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1251/nuon_linux_arm"
    sha256 "1b16a789b67c516e1e211644cbd24242c3198a48f22bb52621d1641410bdc239"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1251/nuon_linux_arm64"
    sha256 "0de1043f3944b80ebdcb432f7b70ec5375c21c2c34bae3ef08515a7b67009080"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1251/nuon-lsp_darwin_amd64"
      sha256 "a03b44e574bb530ef037475235b28eefdb3ecd14b6222f3cc89cc113fc388f4c"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1251/nuon-lsp_darwin_arm64"
      sha256 "5e1377fc1730d4a9b34b0e28984590355d4030085236f799a71e42cfb2dc2e22"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1251/nuon-lsp_linux_amd64"
      sha256 "4a9889f5efafdc4c618f9a67005c1a8fabbc49ad8369974722f8a16c3c37171e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1251/nuon-lsp_linux_arm"
      sha256 "a9321c72181aba6d7f73a43af7a7d21728f7c5d073f438ea58e0ab80e12ec7d4"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1251/nuon-lsp_linux_arm64"
      sha256 "b7897917bae7e51e71205ffe1e0a1456fd423746df3157c98064b96a2007da48"
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

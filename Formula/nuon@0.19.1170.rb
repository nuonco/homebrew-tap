class NuonAT0191170 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1170"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1170/nuon_darwin_amd64"
    sha256 "9fdde78b1c1d9d98604864454bbda056ea0419779997c956052fe7270aedf578"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1170/nuon_darwin_arm64"
    sha256 "95073e2b516ffaa12779c935fc072b717f290729c33a02a535ddb1a05841a904"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1170/nuon_linux_amd64"
    sha256 "2e18be6685a3641d0e593dda406deba8a90afaf03d59bbaa4b299dbf6869cfbd"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1170/nuon_linux_arm"
    sha256 "dbc58806c851db7308b9ea0e69a05821ce3795517cd4b44b2255529360a83a0d"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1170/nuon_linux_arm64"
    sha256 "7da3bd5ecb30e033272dab0b79d61d3cde904223756d703b9b0c95203030fbae"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1170/nuon-lsp_darwin_amd64"
      sha256 "6c7cbdd73cf93cd9e099031494e60b5e9f1e90905115adf32cc04b687c55737a"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1170/nuon-lsp_darwin_arm64"
      sha256 "5aa9922337ddc1bcbb8b9fc9f1d0d0f72db7e1849c728b19756f840e29a281ee"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1170/nuon-lsp_linux_amd64"
      sha256 "aa9278c72c9dd775b50130885c0cd4981a69ceec9f790bf5f96524a9068e6c9d"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1170/nuon-lsp_linux_arm"
      sha256 "8beabe5a2e94b907e436b37b710449e478f6251a7931a3982306bc548c31b2d6"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1170/nuon-lsp_linux_arm64"
      sha256 "9d839ac34d6b23e5feca78911521380fa47103f2e34621ef485a884b4f9612a6"
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

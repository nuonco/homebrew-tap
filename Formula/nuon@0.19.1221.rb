class NuonAT0191221 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1221"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1221/nuon_darwin_amd64"
    sha256 "333b065c9d9f6df14ef5a45bffe9885352cdc9757d61e3745eee54aa36358dc5"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1221/nuon_darwin_arm64"
    sha256 "1a99ce13fe81f2d3b08d24b254dd825f285ef1f60b06e83f5039b23edf323820"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1221/nuon_linux_amd64"
    sha256 "671b6cea34f4491ca6aa87e1436fcd288efbdbda0770136e39134d910c49a84a"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1221/nuon_linux_arm"
    sha256 "b757eadf5c9d7e6507f9d0e5618402db8eff5e6df04aaa459a4616805888dece"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1221/nuon_linux_arm64"
    sha256 "92e48148f6925623ea98336c81d919536a93379d9daf5cd69d7d30c38ad3bdea"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1221/nuon-lsp_darwin_amd64"
      sha256 "4a10c63302f7e76cf5fd0d9c5c8456e49ea73c6f8e5262ee3897bbb41461c690"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1221/nuon-lsp_darwin_arm64"
      sha256 "57f0f277db8d7e23635028611692cafc5a9333673a43259ca1e8ef34229a8039"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1221/nuon-lsp_linux_amd64"
      sha256 "0163f1578972b9b3f8a769738e1030e52506743b723c1b2f16084901ae023bcb"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1221/nuon-lsp_linux_arm"
      sha256 "678fba94072c44d286fab2868c81f1e4c33c277e648fb147aeea8f9a2b146d92"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1221/nuon-lsp_linux_arm64"
      sha256 "d213769d90fb44c2c702ba465d4ab2ccf43af7dceb953786972209044be6f245"
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

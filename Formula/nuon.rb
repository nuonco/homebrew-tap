class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.789"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.789/nuon_darwin_amd64"
    sha256 "90af7ae93805fc5fa01b912c0f6e0c5aedfda0a486d3d181b7d44ba175e01665"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.789/nuon_darwin_arm64"
    sha256 "18a2ac4dd4ee5f1d76c6be8ebe2fef63a5c062492e66462d3d5a5030dde6dc9b"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.789/nuon_linux_amd64"
    sha256 "ffd068e34b6a3718b820cf1b66ff39b96d24bfd70128b89ed6aa5f9066ffa9b3"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.789/nuon_linux_arm"
    sha256 "89daa5bc7eb9134714458b08332602b50e5436e2c51e61b431ee9511cdf29b26"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.789/nuon_linux_arm64"
    sha256 "ef02807bfd5e86ad253aedd5995513ee6ef20d62c8d8aa3e786942e8f74fef9d"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.789/nuon-lsp_darwin_amd64"
      sha256 "1b08e2842603bfb576a9d382e2f4c1dc91f270c741d23d7c3c7668df3577509d"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.789/nuon-lsp_darwin_arm64"
      sha256 "e76c689e54cb2382a4f78d82f1d6edac1b08156d95d9cd759551de49ee1dcd33"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.789/nuon-lsp_linux_amd64"
      sha256 "883bf5b3bde755f6b7bcbac9e9bed2de1ca65302e03f97c87dee9cd55621d7ff"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.789/nuon-lsp_linux_arm"
      sha256 "0c5fe5a5eda36e472e892c78c17e0453fd28d92510a051edd7938ecaaf7ecd37"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.789/nuon-lsp_linux_arm64"
      sha256 "3775410312001adca66deb6e05d944a86fb0e0c7a3c4ec62b14d5681b014ab78"
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

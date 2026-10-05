class NuonAT0191224 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1224"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1224/nuon_darwin_amd64"
    sha256 "7659e04a8c897d813f3b6d271331ed713b799ab8359eea205245bf924714873d"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1224/nuon_darwin_arm64"
    sha256 "dd9f06cf47dfa0d68458b020ff3915711f5b4be4289d170db1bac241096be455"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1224/nuon_linux_amd64"
    sha256 "e41b0d652b7abd692a0b916cab365ba3053943952d5d84162fcae2e461d5e000"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1224/nuon_linux_arm"
    sha256 "6529facfdc1e8b2d18d0c1abd9a2cef75cf748ca6d96fa049b16e5cd01e667e9"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1224/nuon_linux_arm64"
    sha256 "535dce17dfb629747054e955bcb95a45e68ecde982200ac9c630778e492f24df"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1224/nuon-lsp_darwin_amd64"
      sha256 "9bc2f4e71dde4de9379ac77e8c01f15bd6c0f04dd1a0797804563213828ca17b"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1224/nuon-lsp_darwin_arm64"
      sha256 "204afd905db8f090dc35831dab96fb798d2b43c7f35f30ca38a41e25097a1946"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1224/nuon-lsp_linux_amd64"
      sha256 "0e2fc617394e3ed03c0cec50138c12fd8ebcafc824d244d92ae009042b216156"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1224/nuon-lsp_linux_arm"
      sha256 "ba0d90adeda9843ce743d0ee96b2314d1842c17a5f24724b3cc99b3152540562"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1224/nuon-lsp_linux_arm64"
      sha256 "299a48ee1c664bfad37d04a5921b0de00e6caa5793ea537a134faf89744b2224"
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

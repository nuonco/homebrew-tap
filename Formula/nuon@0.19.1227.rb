class NuonAT0191227 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1227"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1227/nuon_darwin_amd64"
    sha256 "0db01bb38f68af53ca0476caea7574b40fa65e5aba82268e2cb3acb9cbf5fef9"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1227/nuon_darwin_arm64"
    sha256 "2779203683022ee284010191c448d1cbfc9297cc3694da55eeba39109d248e95"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1227/nuon_linux_amd64"
    sha256 "07436b8c3b02e924ae2365003351bedf0fd33014e86d1ad4aab24eff9f39756c"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1227/nuon_linux_arm"
    sha256 "2ecd04904e4e67be0f9832f42d5cb8f8a771efa267cdd7f679b84111efad90db"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1227/nuon_linux_arm64"
    sha256 "fe6cb655e13f9bdb3b5f8de242836fb3013ebb695a25dbb7026ce492754ac836"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1227/nuon-lsp_darwin_amd64"
      sha256 "9bc2f4e71dde4de9379ac77e8c01f15bd6c0f04dd1a0797804563213828ca17b"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1227/nuon-lsp_darwin_arm64"
      sha256 "204afd905db8f090dc35831dab96fb798d2b43c7f35f30ca38a41e25097a1946"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1227/nuon-lsp_linux_amd64"
      sha256 "0e2fc617394e3ed03c0cec50138c12fd8ebcafc824d244d92ae009042b216156"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1227/nuon-lsp_linux_arm"
      sha256 "ba0d90adeda9843ce743d0ee96b2314d1842c17a5f24724b3cc99b3152540562"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1227/nuon-lsp_linux_arm64"
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

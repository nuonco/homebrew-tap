class NuonAT0191226 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1226"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1226/nuon_darwin_amd64"
    sha256 "c582ea68c81dbc2009afae4e87586e5275f31d30f41ca9075819947e2eae7e7f"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1226/nuon_darwin_arm64"
    sha256 "5894c3f1d05ac7a5b2ed83f43cf4d6eb05ac480062cbab1706de200c6e3ec6c4"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1226/nuon_linux_amd64"
    sha256 "1c286a1b10ce46f5ce2339f6c80b826983c6ffb7ebd77d750ca613cf86528e9e"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1226/nuon_linux_arm"
    sha256 "701b9723aaf9e31334c59748a93a0fd30aa2bc2b87bb67d9a9b2dc9ac4938f4d"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1226/nuon_linux_arm64"
    sha256 "a969f32889958db43ebe0360a5a4a3d4ea688edce9ab77ba1c4ee77c0639d84e"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1226/nuon-lsp_darwin_amd64"
      sha256 "9bc2f4e71dde4de9379ac77e8c01f15bd6c0f04dd1a0797804563213828ca17b"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1226/nuon-lsp_darwin_arm64"
      sha256 "204afd905db8f090dc35831dab96fb798d2b43c7f35f30ca38a41e25097a1946"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1226/nuon-lsp_linux_amd64"
      sha256 "0e2fc617394e3ed03c0cec50138c12fd8ebcafc824d244d92ae009042b216156"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1226/nuon-lsp_linux_arm"
      sha256 "ba0d90adeda9843ce743d0ee96b2314d1842c17a5f24724b3cc99b3152540562"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1226/nuon-lsp_linux_arm64"
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

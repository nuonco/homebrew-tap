class NuonAT0191287 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1287"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1287/nuon_darwin_amd64"
    sha256 "de9e05ac406ddfe5ad9f2c1ede0209b83a8e7afa5350828c49f9ccf1b80cdf44"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1287/nuon_darwin_arm64"
    sha256 "3c70b0d1e23ae2c1b969d9bcaaf87289e3bcda5f76b55ee9f7ea90a767fad74e"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1287/nuon_linux_amd64"
    sha256 "a64507ca9491bf4cd979485028f4694d1f98257e8eec544c66bde9e4840db759"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1287/nuon_linux_arm"
    sha256 "ffbd0dc49cbb3e71e561dc9ce4edc88bc66e48a80fe3e22b740985705bf482e0"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1287/nuon_linux_arm64"
    sha256 "07ea87dbf56639a751cecaf519f3d6c7e0e7a24234afffe513860e67c2214787"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1287/nuon-lsp_darwin_amd64"
      sha256 "de3288d042b3bc099952ee6e6cfa4b1c04beb401803f492637716ab96e2494d3"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1287/nuon-lsp_darwin_arm64"
      sha256 "af2855736fb59226881d306d256be40e0c818d0be753cdfa53d76dcbf5abf7a2"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1287/nuon-lsp_linux_amd64"
      sha256 "16ad5ddd0cd2d3841ca256f98ffbed97fe50301106b40ad7feb352bee5ebdd94"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1287/nuon-lsp_linux_arm"
      sha256 "d5afc5bfc2c098dfd89680d5744f8f3b56aa53a3d033564424403fb50730b2c6"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1287/nuon-lsp_linux_arm64"
      sha256 "dccdccd501564ee84c4ffadaeb54d2c15eb92e8d2dd74472ef1226e6e80ffe5f"
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

class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1286"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1286/nuon_darwin_amd64"
    sha256 "b97cd78a8dfb6794a17c8dffc7efa3fb1609f4b421f75a6464538465685c210f"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1286/nuon_darwin_arm64"
    sha256 "938f968aef9a5749b2259422ceccf4c3e91ff5b91093a2ce586cda3db497abc8"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1286/nuon_linux_amd64"
    sha256 "4ec358754de8407e9ef2d8767748433fd19297e1be52bdaa96d0d81c60921553"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1286/nuon_linux_arm"
    sha256 "decf7fd363e1456a4d0209c9685ab0731a3fd34e30d478ae4c223fb1b6444537"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1286/nuon_linux_arm64"
    sha256 "404752d9bb83dbb4a9969b7b32864c3e0162abae2662aa52641e7365dcc1369b"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1286/nuon-lsp_darwin_amd64"
      sha256 "de3288d042b3bc099952ee6e6cfa4b1c04beb401803f492637716ab96e2494d3"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1286/nuon-lsp_darwin_arm64"
      sha256 "af2855736fb59226881d306d256be40e0c818d0be753cdfa53d76dcbf5abf7a2"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1286/nuon-lsp_linux_amd64"
      sha256 "16ad5ddd0cd2d3841ca256f98ffbed97fe50301106b40ad7feb352bee5ebdd94"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1286/nuon-lsp_linux_arm"
      sha256 "d5afc5bfc2c098dfd89680d5744f8f3b56aa53a3d033564424403fb50730b2c6"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1286/nuon-lsp_linux_arm64"
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

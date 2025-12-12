class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.718"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.718/nuon_darwin_amd64"
    sha256 "4602ebcd7b79ac6454e738fcea1c53292b3175cb78aa4be4a51b68193d1cc66f"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.718/nuon_darwin_arm64"
    sha256 "aca71de5309b090bc0ef863d6a45d1fd2258f76ab145a02cce7ba2531ac163b2"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.718/nuon_linux_amd64"
    sha256 "d59aeda9206d81d5b2ffd035c20c6c46c1d98e336404d74b76774fa93830bd6e"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.718/nuon_linux_arm"
    sha256 "979c131e720ab09d41e90e8a91ccba8636adf62be9f57180f6b62e2413234489"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.718/nuon_linux_arm64"
    sha256 "8beb54a77e1b858ff3a1835547f9314e117572034dcd64407410c9abc5a2dc1f"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.718/nuon-lsp_darwin_amd64"
      sha256 "91e75bfe30d23c9b6f539e93aaeed980fd4f63f184185168ec497479636c00db"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.718/nuon-lsp_darwin_arm64"
      sha256 "95bc44fd4f10f3338d2eab8ae5d945a3b8198364761e95d441043d0c12626641"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.718/nuon-lsp_linux_amd64"
      sha256 "7771d8cf000d7e83eb14151adf6d21249b9c686ded95551a82c439500c71f36d"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.718/nuon-lsp_linux_arm"
      sha256 "c9daee0ed2a3d0d36ff4ba45fa8939e8d720651f969afda9ecd7d9d02c396d8a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.718/nuon-lsp_linux_arm64"
      sha256 "acd24f0427873e377853804f8cd303c2c24eef5ccb212b454fa8e9976dc066eb"
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

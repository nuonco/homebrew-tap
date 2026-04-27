class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.899"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.899/nuon_darwin_amd64"
    sha256 "718735a98f3199df1821366a4c608bc0910a01e5eadae8046bd02834eb805006"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.899/nuon_darwin_arm64"
    sha256 "98fde648a1076d38e7de09140a8291b2a5a5a7470eb6525188e6a7b90d7df8a5"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.899/nuon_linux_amd64"
    sha256 "25f92245ac731066979f96bcfcbcadc206231b5a43cdf5f6bbf200ceb3ed80b2"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.899/nuon_linux_arm"
    sha256 "1bf388801aa8801a3f54562d6db4b5febc099321b0358d36847245a79970ceef"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.899/nuon_linux_arm64"
    sha256 "725c41df6629b3a750aeec75306711851fb5d4dd4c696a62c50a91a66468b511"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.899/nuon-lsp_darwin_amd64"
      sha256 "a871d55b62e38c9a3c9a3282831133a21e78393b13111fdfa150cb68d3fff14f"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.899/nuon-lsp_darwin_arm64"
      sha256 "07d5c8d30c6185f98811e5ee34c113b50a0d3d40bdafe0a43ed1bd9867bdb355"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.899/nuon-lsp_linux_amd64"
      sha256 "e4e2d203f387c9eed1131bb637f3d18e12c9c2d06324193d35c80e1e056f3847"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.899/nuon-lsp_linux_arm"
      sha256 "85079b17ecafdb116b3a1e338a309649aad604a9e81bed1e003a6823fb407c5b"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.899/nuon-lsp_linux_arm64"
      sha256 "791fc8b2834df964c1c5678afff89183069f01d56412395454271ecadf5c2afa"
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

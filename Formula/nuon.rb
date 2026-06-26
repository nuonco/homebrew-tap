class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1019"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1019/nuon_darwin_amd64"
    sha256 "f353885da8b27c7bee230524f407bb5e31e782e0ad5db5a123676d5741f02913"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1019/nuon_darwin_arm64"
    sha256 "f3a54112f8a08b3f2b64723676b64d512bf660a5a3eb65224713a1bd6d161685"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1019/nuon_linux_amd64"
    sha256 "e230fa1e4071815040134598688e7ee26a41c0c55d9a8591c2de357bf4f7c11e"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1019/nuon_linux_arm"
    sha256 "88a32faa2ad28a01f72e9f3a79983a137c6d7b89e6f01c4e911087db860845f8"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1019/nuon_linux_arm64"
    sha256 "d6c9d0d8834d149f203128228995a3f70369bd5601f8ab249275492b6337346f"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1019/nuon-lsp_darwin_amd64"
      sha256 "54319fd79b8be5f0a922bd6db6fc6041f043662c795543ceb9d7e367a016142b"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1019/nuon-lsp_darwin_arm64"
      sha256 "b9f61723f9d7f1712d2d364535fd8978972f2b55d63087a20b963e9140e2ad80"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1019/nuon-lsp_linux_amd64"
      sha256 "47376e0bc160604e86775363ff38886318a775243ba5633f11658bbfb9d5d118"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1019/nuon-lsp_linux_arm"
      sha256 "fde03453b3f68f580d0af11143198b802f41106e29bbac6a98f6c612e6a87aea"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1019/nuon-lsp_linux_arm64"
      sha256 "91d6357879edb06ef920b3daa9d7aa9272d9e535f0daa5ddd071dbc3d197f5c9"
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

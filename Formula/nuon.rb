class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1020"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1020/nuon_darwin_amd64"
    sha256 "a7f442a1ef03d7999aa83d839bcea051413ea16fde3a1404c568391bfdf3fb60"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1020/nuon_darwin_arm64"
    sha256 "60e7e10e7b3f05a7d2457d680fca181a05966a89f18a6991e623f5ba94a142af"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1020/nuon_linux_amd64"
    sha256 "dd5ca148d488579ba7751cb0b1a6d1629b386951930f0a9e26956dceb51f62d8"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1020/nuon_linux_arm"
    sha256 "1682862b3355275b21e681d6d7e2d287bb1b5ca3e987195c0afb09485480c0bc"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1020/nuon_linux_arm64"
    sha256 "b614eebf46ff7c7e662c9075397ca3c872ae56d777d6bca1ef038575c2fc21ca"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1020/nuon-lsp_darwin_amd64"
      sha256 "54319fd79b8be5f0a922bd6db6fc6041f043662c795543ceb9d7e367a016142b"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1020/nuon-lsp_darwin_arm64"
      sha256 "b9f61723f9d7f1712d2d364535fd8978972f2b55d63087a20b963e9140e2ad80"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1020/nuon-lsp_linux_amd64"
      sha256 "47376e0bc160604e86775363ff38886318a775243ba5633f11658bbfb9d5d118"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1020/nuon-lsp_linux_arm"
      sha256 "fde03453b3f68f580d0af11143198b802f41106e29bbac6a98f6c612e6a87aea"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1020/nuon-lsp_linux_arm64"
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

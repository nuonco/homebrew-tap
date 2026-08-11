class NuonAT0191117 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1117"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1117/nuon_darwin_amd64"
    sha256 "fb3b8b5435b3c7cb7029eb1e10ab046506196d4493ef1012c5362c0258d16c91"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1117/nuon_darwin_arm64"
    sha256 "8a0e37190681fbe2b5f7e07a8d4254b67a72362d22f95f95a609a36e8aa6241e"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1117/nuon_linux_amd64"
    sha256 "deeba056417ace1ed9b8677f92c0f177119a7cfbb164bda57a81c8f3cdc72b38"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1117/nuon_linux_arm"
    sha256 "dc424fc586b429e6eb928b86b4099e4062df872c22a9595356e9727f2f42ce88"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1117/nuon_linux_arm64"
    sha256 "817e0633f2eb2ea735de4cbc5f80d8f72b6e8d7983db4185fa053c5d9b691a67"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1117/nuon-lsp_darwin_amd64"
      sha256 "7802e84e965e5fa2e1be19f7ce708aac4d90b22e7f26590d58f740be0370ce32"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1117/nuon-lsp_darwin_arm64"
      sha256 "43eb840dc75d0d2fde7c07055fc1744d2f704d110273382b8689d90f7f1f2097"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1117/nuon-lsp_linux_amd64"
      sha256 "0977b3f3db9d719d8ffb077695b74f6c51a71fb33ceff32d8ead97be5cb66292"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1117/nuon-lsp_linux_arm"
      sha256 "e25ff6dd294b250d3ff007d6c0654f305a7033054a1061ac5557615cfd3c495f"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1117/nuon-lsp_linux_arm64"
      sha256 "e8961eeb787a78f661ff784c8079b1fa4eb88756569062f4bd20f0890de15fd6"
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

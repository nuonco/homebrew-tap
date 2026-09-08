class NuonAT0191166 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1166"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1166/nuon_darwin_amd64"
    sha256 "02bfae6b799fe8e72b4d2b5a1e651cd4afb7dfbecdf4a274291c6d94adc271b9"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1166/nuon_darwin_arm64"
    sha256 "bb734deb67ea31ccee5ff698a35ac4399c9d519017e748970c93d60eee3643fe"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1166/nuon_linux_amd64"
    sha256 "3bfcb3e0267909f193bfb9b999d9e55f97ff8a0048249728ddadfde1439f4d70"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1166/nuon_linux_arm"
    sha256 "e74b21422618e347e640e36a524e59f454b386362734b6d876c69a45ba6e0e8f"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1166/nuon_linux_arm64"
    sha256 "8e0ade266347b268ac97fb3dd4c9de138fbc239f8824dc7f231e2fc8027fbb44"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1166/nuon-lsp_darwin_amd64"
      sha256 "44dcd6858372922f383f87c03a049d5ccb5dda2dbe113b8e926847c8a85ebbcf"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1166/nuon-lsp_darwin_arm64"
      sha256 "11d4e14cfb99b93abdde900e5f076981f798ea6faa3a0bbcb6b2fb81d1356c5e"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1166/nuon-lsp_linux_amd64"
      sha256 "54cbada39923e2e58593227e619bef2cfb6372d70a6d3364be73aa3e3d7dc953"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1166/nuon-lsp_linux_arm"
      sha256 "6c4b0ccc7488646599e0ff613895aec87426351f4763d3019ac4851488b8b165"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1166/nuon-lsp_linux_arm64"
      sha256 "05b9c515ceffa631e5fd02ed386911bf497e3586b0d2bb01675e279fc28ef6c7"
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

class NuonAT0191228 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1228"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1228/nuon_darwin_amd64"
    sha256 "1f1385b5ffd969d6859e63de04eb22affcd92b1764c0fde2f5b3365bc3b6ff9e"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1228/nuon_darwin_arm64"
    sha256 "86f0bf2be9c16c46124dbc32dc9e6b3a891fde343e5c6db47674dfaba7296f18"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1228/nuon_linux_amd64"
    sha256 "bd6b0dd1251bcca9da11131ba39bbdb08d6fa373acd86bdc0bd3573ee7d0d08a"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1228/nuon_linux_arm"
    sha256 "520d25429e2ed508107820acc6a34b5552f64faea3156f7a1dbc464afe99a4fa"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1228/nuon_linux_arm64"
    sha256 "7afd9d81c20352c8473d0ac3a26a114942094a22272a9fc23821b1187587b5cb"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1228/nuon-lsp_darwin_amd64"
      sha256 "e26c16b28e38020d6364af344283cee816344597dca01c54ea693bb3724ee90a"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1228/nuon-lsp_darwin_arm64"
      sha256 "fc4694f2b573d5470915c9778f401f62a509e5f3091d5ff3e1c956c6d7e59dce"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1228/nuon-lsp_linux_amd64"
      sha256 "d53e67d8ae3b5bb08f75148c1f3994f51c494502202f6b10f31cbff55fb9bec4"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1228/nuon-lsp_linux_arm"
      sha256 "9ebc57a4462dae8f100f9b04475348f5525ea4122777a8ff1984755900719cf4"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1228/nuon-lsp_linux_arm64"
      sha256 "d32115149a49dd18628bfb9a97bea40358f09dda78c2f8ffdf3472bde356715b"
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

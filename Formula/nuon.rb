class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.771"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.771/nuon_darwin_amd64"
    sha256 "1b0dd30537bcdd8a5c7866783125c9ffefa260ee141cb9c47f09dbb91104fd18"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.771/nuon_darwin_arm64"
    sha256 "0da71dd84fd4d55eae12778ae40e166fbfedcb15fb18e6cb9cba3829ef106e7e"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.771/nuon_linux_amd64"
    sha256 "0e24a3fcc45a692f35ede733fe964ae3f20da182fabad5e92f8e73f3555c80f2"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.771/nuon_linux_arm"
    sha256 "de251a22195a5650accfa35cc4380bf4a8aa61793cfd45802332c5be849a8d6b"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.771/nuon_linux_arm64"
    sha256 "fa9c31f2e2f36fa6cddc170699e0677ad556af44200ee31ea0513d7e0c347cdf"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.771/nuon-lsp_darwin_amd64"
      sha256 "89574565ed1c1a33087e0ba68fbff7002cf20e27706e0b073c98992547c52696"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.771/nuon-lsp_darwin_arm64"
      sha256 "43ce85ae61c182766d31a905f713e8bb26370e8f7ddf7c8ca873b30640ed95ef"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.771/nuon-lsp_linux_amd64"
      sha256 "c2c6c83e90d3af742936752fa16a84a39045d3549c90198a47935d4dd809ca61"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.771/nuon-lsp_linux_arm"
      sha256 "18d0ac064ca60645b72a1c80ee663c179fc4765fca9e8b672440b3459c86e739"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.771/nuon-lsp_linux_arm64"
      sha256 "fc8a7666a7ff287fcb33f73bad63e693ca91aa5bd9cacd8ba2b7fe9cf944881d"
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

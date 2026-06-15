class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1011"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1011/nuon_darwin_amd64"
    sha256 "c71c7ea7b19c56ed0eed60157ef9a23f41f0ccfeabfdea5eb1b38a1c6e95c27a"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1011/nuon_darwin_arm64"
    sha256 "99cd968a1bae69b6153a4912e6a5a249dc062018d794c0fd008b6af1a1b09eec"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1011/nuon_linux_amd64"
    sha256 "cfa20b4c9f9f25eb53215cffa32216156c397cd4f5725a043be98bcef6de0900"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1011/nuon_linux_arm"
    sha256 "5cf37aa5b6d6e838efc1cd8771d91504338b543b5a394a7a2559260eff5fda7c"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1011/nuon_linux_arm64"
    sha256 "3873aac811a2b325cd63d7112c756975d65828ca8e5a0e2cabcf42adaa634cb3"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1011/nuon-lsp_darwin_amd64"
      sha256 "3891b6b4a6625b1827c1f685abd44866808c0531b45f9b2f2448872fac21b176"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1011/nuon-lsp_darwin_arm64"
      sha256 "b28bfbea2e3b79341b86a5553596b70b238f9c653ff67b198f02743236a57640"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1011/nuon-lsp_linux_amd64"
      sha256 "0d5d9502d68697c2bc84ce343e8282415c9349b31690f96a18f8c46f15aca35a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1011/nuon-lsp_linux_arm"
      sha256 "113f8bb4618496b3f4298566d184c15cd047f6990ac4fcae856fcc39a3e93e5c"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1011/nuon-lsp_linux_arm64"
      sha256 "e6ee5c66ff95f69a29230eeff09f6b268a18a60defb8418890415a83fda51e53"
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

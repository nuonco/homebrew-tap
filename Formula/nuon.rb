class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1009"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1009/nuon_darwin_amd64"
    sha256 "2b17e27ae3a6490a76cf92650d0c515bc7290cdbe5abf5b48805761f14c4967b"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1009/nuon_darwin_arm64"
    sha256 "a3e9acf0c3a586cc4b60d9068a62ad71c064e711a5552f8a9c7471f4c7a3ef1c"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1009/nuon_linux_amd64"
    sha256 "1d6ecd9ee2f1010d8809da14d6da1ccc40a5a591d674ff9d2048828041535267"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1009/nuon_linux_arm"
    sha256 "c66767634a4b5f3d917b1cc281bb4a0478557a1788030b37220ea03b27da75ce"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1009/nuon_linux_arm64"
    sha256 "c1e0d5ce2c884fbf3167c5c1cb182ca45e7b6077e033f6c141749b161a679cc6"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1009/nuon-lsp_darwin_amd64"
      sha256 "3891b6b4a6625b1827c1f685abd44866808c0531b45f9b2f2448872fac21b176"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1009/nuon-lsp_darwin_arm64"
      sha256 "b28bfbea2e3b79341b86a5553596b70b238f9c653ff67b198f02743236a57640"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1009/nuon-lsp_linux_amd64"
      sha256 "0d5d9502d68697c2bc84ce343e8282415c9349b31690f96a18f8c46f15aca35a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1009/nuon-lsp_linux_arm"
      sha256 "113f8bb4618496b3f4298566d184c15cd047f6990ac4fcae856fcc39a3e93e5c"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1009/nuon-lsp_linux_arm64"
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

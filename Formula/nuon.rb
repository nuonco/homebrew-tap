class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1010"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1010/nuon_darwin_amd64"
    sha256 "d931702863e3160ab7101e07402c4c1801c303a6e429c883feefe76d37508edb"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1010/nuon_darwin_arm64"
    sha256 "8e723373202545585e47145bef99def3bbe1a91f034bf22e842543190d5fa0c1"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1010/nuon_linux_amd64"
    sha256 "160e1ad94e1b14f00d85414c217620529cfc8c253b7760dbdc299b02f5d818c5"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1010/nuon_linux_arm"
    sha256 "dcc04c83e2eff96bba202c634de1366bbb51ed3a066a296a97a9708461652199"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1010/nuon_linux_arm64"
    sha256 "f0c955ea22ca5cce24a106c91f698a0f7f33aca086e9bcce29a6dfd9f67227c5"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1010/nuon-lsp_darwin_amd64"
      sha256 "3891b6b4a6625b1827c1f685abd44866808c0531b45f9b2f2448872fac21b176"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1010/nuon-lsp_darwin_arm64"
      sha256 "b28bfbea2e3b79341b86a5553596b70b238f9c653ff67b198f02743236a57640"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1010/nuon-lsp_linux_amd64"
      sha256 "0d5d9502d68697c2bc84ce343e8282415c9349b31690f96a18f8c46f15aca35a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1010/nuon-lsp_linux_arm"
      sha256 "113f8bb4618496b3f4298566d184c15cd047f6990ac4fcae856fcc39a3e93e5c"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1010/nuon-lsp_linux_arm64"
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

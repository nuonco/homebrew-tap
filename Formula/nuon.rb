class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.999"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.999/nuon_darwin_amd64"
    sha256 "80f3e9163cd67f7ff3e42a197b42b5c3baf1336329085a6e49752795f97227b0"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.999/nuon_darwin_arm64"
    sha256 "64947fc80dc2375d95ded20df1c7c5cf118b9bc63b69267221fd4f9d95e27bc0"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.999/nuon_linux_amd64"
    sha256 "06194330e31d71d9d73096aae04c3d5258adc4ac0120fef6527f2dc8bab694a1"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.999/nuon_linux_arm"
    sha256 "93ef6e0d98c20358b174e38d3676ad08ef19135f386f334a6f443dff39db49a2"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.999/nuon_linux_arm64"
    sha256 "017ed5a7641a4972368bd61d5cc2897c0f7182c51c1f5f5ed1e8125558a7c456"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.999/nuon-lsp_darwin_amd64"
      sha256 "e770293eb0e8da8ed0c04f67f793a1ff28b3bbe203997fe9e4c733faa7136544"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.999/nuon-lsp_darwin_arm64"
      sha256 "cfef9a317718f99156268ef26c5ee36f84fe4cd39fe17aceac9b9d2a16d933fc"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.999/nuon-lsp_linux_amd64"
      sha256 "5f64ac3b72503d1e423158e799f59b0c6e2eda245b5e6ad0fc22c5fd60f72219"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.999/nuon-lsp_linux_arm"
      sha256 "592ebaf3c97cc2f1301fff01d9ec3fa15fbe944ad780851b3003ced3c7eb0c74"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.999/nuon-lsp_linux_arm64"
      sha256 "d9f8e92ae106ca0b88cf92c4ca51457d4b393bb5ac70b2f77664abefa11fd6d9"
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

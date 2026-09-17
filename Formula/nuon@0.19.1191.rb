class NuonAT0191191 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1191"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1191/nuon_darwin_amd64"
    sha256 "39dd95d40c7cae32ccd9bf6dff05f1dda18d78630b384f56216f8ae69c21de68"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1191/nuon_darwin_arm64"
    sha256 "3dcb02c7337fa46ce3b81b33613aa67b52506a4d63be5089a6ff4ed5fc0341cc"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1191/nuon_linux_amd64"
    sha256 "550a05bacbda85a9a1818ff9dd1f382431f07b6bf2f5b097f14fa98df3477d5b"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1191/nuon_linux_arm"
    sha256 "909f3194c185c0126085c6af019e360a315340e597de23e8bd1669dda00903c1"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1191/nuon_linux_arm64"
    sha256 "ac4c6f7a9797dacecbf213d4db605897983635f61283d6b107d31c1abd70ef38"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1191/nuon-lsp_darwin_amd64"
      sha256 "11efa0b603745ff2e1bc629ac39558b4a53474f22ddea5fda286bfc47fe89f2f"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1191/nuon-lsp_darwin_arm64"
      sha256 "6c06d9852b87d0bdbc6d3e8cfa21abddc11fdfa08e972d8f42d122f317bbfa50"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1191/nuon-lsp_linux_amd64"
      sha256 "a2596a7516b786a92b4762714f7671cde230ab2d976ade7df9088cfe226cf2c0"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1191/nuon-lsp_linux_arm"
      sha256 "42080f6110209a7374bd342640c7737af1c4a1c90e07e548c18145c8eec496ac"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1191/nuon-lsp_linux_arm64"
      sha256 "045f87fe96c7f94899921746c6302e9cddbde1c56bb534abe50b78817669ff6a"
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

class NuonAT0191275 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1275"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1275/nuon_darwin_amd64"
    sha256 "4a720dc98bac7ac84e862cd1617d54a603f77923f71ce3fa58fb2b3f81526e33"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1275/nuon_darwin_arm64"
    sha256 "d818d124f16f16e30f98bd981e06c7ca543b3e80e0f342a2b37766e0c151b816"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1275/nuon_linux_amd64"
    sha256 "68cfd40bc7803eb22c7080a5e873215f2a1b39f3c98adc22849b6ab15e5aa9e9"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1275/nuon_linux_arm"
    sha256 "f8649be89757347cb9f1d0e04192ba373b30c35cde191233625ef3516c7fcd6d"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1275/nuon_linux_arm64"
    sha256 "67f6dd3c28098b89324593c6e8acb0a55c038ac1f2248be49a3dae4d25e066bb"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1275/nuon-lsp_darwin_amd64"
      sha256 "eec9f06de5597d78b90b63ae3ca5cb9882ce51a17ce1c1511c141fe9c66e2b1a"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1275/nuon-lsp_darwin_arm64"
      sha256 "213c8752356094619e74b043933444944b2f5896383c02e2e774c6ee7e8fb089"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1275/nuon-lsp_linux_amd64"
      sha256 "8c1f17aebd96071b9002129e1baef3aaab1ebd8c683a48c0290e48d17f01deb7"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1275/nuon-lsp_linux_arm"
      sha256 "f0ba8c88977a95772808849f3e49f6a5484c96680ddee6081464dc764965e003"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1275/nuon-lsp_linux_arm64"
      sha256 "da44296540039db139e4fa0aa25c180e2dc94d9976b4813735951f403918ead7"
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

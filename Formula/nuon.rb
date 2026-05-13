class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.930"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.930/nuon_darwin_amd64"
    sha256 "e5dccf8385b0751bc31c687b6d45c702112659591caef8694801ffa989ff4c87"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.930/nuon_darwin_arm64"
    sha256 "77dea56d188f4cebdbc61ba4eb176d8c2855f17dd9a2fdee821710c984f28ac1"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.930/nuon_linux_amd64"
    sha256 "1345cd5f09c107fb10476cb37ab55b52966198926b0cb0096ef0b80117a0361f"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.930/nuon_linux_arm"
    sha256 "04c787ae5d33b6bdfe449fcbab1947157b56398dcddb272b3df417519ecaf7d8"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.930/nuon_linux_arm64"
    sha256 "12f1f3b81f12986816df1cd5651238dafc07871602ac8cb26ad5cbd833c5f2ec"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.930/nuon-lsp_darwin_amd64"
      sha256 "cc67bb437922518de53ea374a42a1c10dd6c282f2e2b16ba95a0eace03164bac"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.930/nuon-lsp_darwin_arm64"
      sha256 "c0ceeadfbf91a1b896bf07a64cc13a3f94390f6e0c2c057d2b18703124fad051"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.930/nuon-lsp_linux_amd64"
      sha256 "cc66bd00197f0518f9497f832d4d95de3b476e7c8ffcccd6b80cd7b73302f992"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.930/nuon-lsp_linux_arm"
      sha256 "121d8f29e9a4ea08527d8aaaf8bc6dbde2728561ebfaf57c94d750d57a09f831"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.930/nuon-lsp_linux_arm64"
      sha256 "8e9a41077a1ae7ec72cee466ff45ff164b4752315addd90733e55e3eb1966863"
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

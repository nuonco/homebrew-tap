class NuonAT0191244 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1244"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1244/nuon_darwin_amd64"
    sha256 "eafbe51a51c039d49be5a911d785a5b25fe72cb592b020c1268ba28d2d5fe9e2"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1244/nuon_darwin_arm64"
    sha256 "fc81ff4b6a2c4ce40017b329d0c9f573844170712fb71e15e5611e92d02a8108"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1244/nuon_linux_amd64"
    sha256 "677030817eb58445553a65f3b1eded97f50d26b8dbde63d89b328b391bffd805"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1244/nuon_linux_arm"
    sha256 "2dc2f2b6f1dc1e8807bff56a3ee710230afa3a9c6b4c8177b941b55c31c3f1e8"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1244/nuon_linux_arm64"
    sha256 "fd9965ffbdc850d49631d9c80849099ca49a61fe0e8c3b1e018bf00e0c76274a"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1244/nuon-lsp_darwin_amd64"
      sha256 "2c0f5f87cc1cc6b1ef08554219360e63158e87489fa7139ab3e4a5dc34b2a5c3"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1244/nuon-lsp_darwin_arm64"
      sha256 "2fb7cfcdb50b330e752ee696dadca91a0cc073237ecffc024808d73b012d5550"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1244/nuon-lsp_linux_amd64"
      sha256 "c63ce773f38c123dd05ced3c78a5919865ee5222084a645d0036920d7656a687"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1244/nuon-lsp_linux_arm"
      sha256 "2074f47647fd5de1b97102c4c29b1fb9a5b2145bc115de46081e7765e281bd47"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1244/nuon-lsp_linux_arm64"
      sha256 "c90cc00e028452872f10135ea3fa477878683281a06236ce96d6f98c4eea509c"
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

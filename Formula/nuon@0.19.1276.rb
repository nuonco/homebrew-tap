class NuonAT0191276 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1276"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1276/nuon_darwin_amd64"
    sha256 "521a6d11c0b17d0de53da486f0d114beb5b1ec2f1ca95041bdb832d2b89f3d6d"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1276/nuon_darwin_arm64"
    sha256 "b541b48755b51b711f03444e8d4d7c15457d74f3f655c7c2f0eb17ac2a6ad65f"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1276/nuon_linux_amd64"
    sha256 "dfd8bb92d9d5a098b9f7d489b078a115ba44c6a9e00b94a27e96e07f9e11ebc6"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1276/nuon_linux_arm"
    sha256 "ad92426ec06bb5972553a23fd34743c9f0249575ee889279f4f86f14651d377c"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1276/nuon_linux_arm64"
    sha256 "7e39c6383c8ec54f4406b70a711d024d7e25d5e9cd48c25d05ed0ef2812cf334"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1276/nuon-lsp_darwin_amd64"
      sha256 "697a8d1f2c4481b2412cd130c379b11e23b9a32502ec29a4846ea1c59c452a45"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1276/nuon-lsp_darwin_arm64"
      sha256 "707621c3ebccfb0158dc1a867cb93b07c697d91078f44f8133c795ce4503c12d"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1276/nuon-lsp_linux_amd64"
      sha256 "cdff8414c43eefa685aace3532dfab1dc0871d790f728894c6ff969943037bd5"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1276/nuon-lsp_linux_arm"
      sha256 "2dc2223254664e0ec607abc4e5e6dd5d29f868434368b0bd65811c8d200ae914"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1276/nuon-lsp_linux_arm64"
      sha256 "7740f2e341e3961ef61b1f1572a77c1a827a5095151e6556765ae2c636e072f8"
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

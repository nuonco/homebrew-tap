class NuonAT0191178 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1178"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1178/nuon_darwin_amd64"
    sha256 "674c88c44ac2b8417fb11e7d4d77152879f0cb8a9e586de2b53e415a20dec161"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1178/nuon_darwin_arm64"
    sha256 "4bbad5b9866e8dd146430ae041581a6db1b9d2825d89279e6b1aa5075223c3f4"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1178/nuon_linux_amd64"
    sha256 "aaa17e672a134e7571b1d392b6717670080909284c19468b43f4ba97d2b2cd37"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1178/nuon_linux_arm"
    sha256 "b1e82f83b8a95cdfbf370cce7ba94e75a7eb75a82f7829f4f11930a3deb28a5c"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1178/nuon_linux_arm64"
    sha256 "bcb639b2eb72ba15f7361b94e04d0840c96366dbf13ebdcf38c319615cd215a2"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1178/nuon-lsp_darwin_amd64"
      sha256 "32cca7831c3c0139b04ed1e296bf26a48c30edb4f340ad3b0c270e6658de43ab"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1178/nuon-lsp_darwin_arm64"
      sha256 "0ffffd91eefd21198434f8371bc09e8319ab1bf09cac5277fa66facd662ee7aa"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1178/nuon-lsp_linux_amd64"
      sha256 "9c4f553b6ec84396a1a9f6b23aea0c476288001001470cf94d289e2f8d5a0112"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1178/nuon-lsp_linux_arm"
      sha256 "2c0dc46bb573474ca722c35f1b4a15f8666162713c2acdbc80a92e6358d03c16"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1178/nuon-lsp_linux_arm64"
      sha256 "0af4b634c4cf8eaeb765dd522985bf249a91e91686604d66c84691cc45b99321"
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

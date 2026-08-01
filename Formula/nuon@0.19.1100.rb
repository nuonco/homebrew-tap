class NuonAT0191100 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1100"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1100/nuon_darwin_amd64"
    sha256 "2736f74934d5d2e1d53576607c40270febfc17291c10dda3eac146f8da5f4277"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1100/nuon_darwin_arm64"
    sha256 "f2dd24a506daaeb9af31942a2f0c0b2ba1dd43d545e3019296774ea35d4c549d"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1100/nuon_linux_amd64"
    sha256 "ca9f7af97c565c99b6ad5078152382dea6921ea191d2f06615267c019aa2d82d"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1100/nuon_linux_arm"
    sha256 "c55dc5a1b852b05c4a949b071459f97a883b6b43758e28f59b45ceb9a835916a"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1100/nuon_linux_arm64"
    sha256 "67cecbbe332d502a0049191c06be3471eb3d8348601ffa0e964c4672519d9ca1"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1100/nuon-lsp_darwin_amd64"
      sha256 "80070d122f430a59a0ec3b746d4f8980bf2028d0e9d95c34daec728c6c6dbdba"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1100/nuon-lsp_darwin_arm64"
      sha256 "6b95a961119cdc4de05b13950c255beffaa161e57b3170286778d5c401e09fb7"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1100/nuon-lsp_linux_amd64"
      sha256 "bee421f264292d571e8209358483e892e1f03678022e6cd350b890ef46048e31"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1100/nuon-lsp_linux_arm"
      sha256 "a03677c1cbce05538c7735b4454b786f85cdf3715b4c542c43578d08c486e029"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1100/nuon-lsp_linux_arm64"
      sha256 "37158e414c16a3a27b50dfbc07ece50601d4948d7af8e03f61c30cbac2f39a06"
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

class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.712"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.712/nuon_darwin_amd64"
    sha256 "8a968d5a171dcbaac4ded0aebea9ce293de165fd160dbaf383b9e0f8574b1e6d"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.712/nuon_darwin_arm64"
    sha256 "9fddd50b31b3489dac7c6e1e1ca10f516916ea613ec4b3ca662f9a5c2ae05bbb"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.712/nuon_linux_amd64"
    sha256 "263f88925478a34b72320d34414355340f406069cf6251d8a9754cdbfeef363f"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.712/nuon_linux_arm"
    sha256 "f0ef4f404ecea882eaa33cd90dc3b1ad053d5edf050564832608d3d45e255798"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.712/nuon_linux_arm64"
    sha256 "3a3e089c3b83f9f9196464c26f6bb3729bb2539b5b284e72633095de05d84951"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.712/nuon-lsp_darwin_amd64"
      sha256 "f0bcb1557c8c06b480ea512bf0e24dc7d5a7bcfae695ef53fe4dad5d0ec9eb8e"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.712/nuon-lsp_darwin_arm64"
      sha256 "77eb58c5fa194157969ef1f6cebf189044652837ef5812e948142d2141dd260b"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.712/nuon-lsp_linux_amd64"
      sha256 "d4d468731ebc4f3c01bb5260484d3699fd5ac3ea8b771d3644f8a11e48920801"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.712/nuon-lsp_linux_arm"
      sha256 "bffd53fac0722e6c02ee65ac632ce1da4ca7f98b6979f8eca0545b5d6b1ff1e8"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.712/nuon-lsp_linux_arm64"
      sha256 "8534bfd69a421a43e590f8f07cb3cb8e44ce073eacde495554f87863d215615b"
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

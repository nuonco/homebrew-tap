class NuonAT0191119 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1119"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1119/nuon_darwin_amd64"
    sha256 "1b62db78c7aecc530e21950b2623ff0cf4b57303fa82159a367f43d599ebcde1"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1119/nuon_darwin_arm64"
    sha256 "581d592a18cfc11e7afb367dd9a4ba2a47af3d2ed88b91b8d9d656397ae0d2f6"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1119/nuon_linux_amd64"
    sha256 "625bccc2a4597739a574c90aa17b68185725cf4472e230b8e8ed696eb6b2c135"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1119/nuon_linux_arm"
    sha256 "a515d97a44fc65847a8cb2fa0f296f4d51e2915943b094aab23b850a378b6cc0"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1119/nuon_linux_arm64"
    sha256 "c8632ff349d93bdc49719f5ba05ed3fa9a25d428c3b34d8d063bba51a275d294"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1119/nuon-lsp_darwin_amd64"
      sha256 "d59a2be2c028e0485b9dba8d4d222e99c8009c60ccae67bddfab85411eef2f3c"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1119/nuon-lsp_darwin_arm64"
      sha256 "9ee720e72916f5d02a9e0470e1a86a92bbd3cf1e5e1a65230dec8bc1fc4566fc"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1119/nuon-lsp_linux_amd64"
      sha256 "88d3bc22cd34fe112e3d8c494f14a0ef069b896170ce186b12a9a306080c636d"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1119/nuon-lsp_linux_arm"
      sha256 "eb2d7bf12a3842b1a5f5b33a1e7532337dc6b6ebc269a28244eceb358e28e5c7"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1119/nuon-lsp_linux_arm64"
      sha256 "c84969b1459b447fbf03aa05b6238d7e84baf1e566a928a3e446378ee8dac879"
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

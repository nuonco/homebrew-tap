class NuonAT0191158 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1158"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1158/nuon_darwin_amd64"
    sha256 "c9d6f6f5088889847416be967a5d49de38fa6610c6582bab743942af07367d16"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1158/nuon_darwin_arm64"
    sha256 "624d5ea81a90558b068ea6b2f469aa235ae0809a51b1e8067440a138bf76eaef"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1158/nuon_linux_amd64"
    sha256 "617b9c2cbb8461855f3d87a8679dca818a427ede4a47e5f411e7707376241794"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1158/nuon_linux_arm"
    sha256 "18bf0eb164926ed7c8981103c2edeffea35357347718ac638f8db2c523975bd4"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1158/nuon_linux_arm64"
    sha256 "442ea085984600ec06adec885df1e8df969ead0e9c97f6745d2a2fc0574f30ab"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1158/nuon-lsp_darwin_amd64"
      sha256 "56a798f94433450f502c259c48c112438ae28eb57adf3ff7606a61f1ce44aa9c"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1158/nuon-lsp_darwin_arm64"
      sha256 "67df3f47cc1c4b288825fe464bb926355016ddad98503759e8885ac468d9c5c6"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1158/nuon-lsp_linux_amd64"
      sha256 "7a6e1dadd4046c5e578f2a47ce3821e639ddb54f4ebcca7d8e07f1d012878bcf"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1158/nuon-lsp_linux_arm"
      sha256 "b81bf08c228eeaa1189ed792df4ca5566fceec2c80061c53eb1aeac42145d9b1"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1158/nuon-lsp_linux_arm64"
      sha256 "d635dfacf7fc0edbe28b049df4f09c0fdffe556ee283748aa8596f588b16b598"
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

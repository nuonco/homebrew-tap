class NuonAT0191149 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1149"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1149/nuon_darwin_amd64"
    sha256 "fa99da09b73ba3fe84f8b248a97f6190686ac04b2c6fe9ee623cf08e16e44302"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1149/nuon_darwin_arm64"
    sha256 "dc52bbc228f1f1fcf3f10dace0179d7f7787aba31cb2403f3aba34a5f39599b5"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1149/nuon_linux_amd64"
    sha256 "76ff39f7b3ee5d878984b9c88b248c147b40d5f439cc66b89b2deec29e816465"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1149/nuon_linux_arm"
    sha256 "cdd8f57f200b4bd34721ba6ba11ec3193f2901b80a9f0b2df5beec412fde7ab1"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1149/nuon_linux_arm64"
    sha256 "ce77d76604bb2e01eaf4356ab2470826246f9846a5b9d24f4eb136cd26a71916"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1149/nuon-lsp_darwin_amd64"
      sha256 "f6802f8307cdae7f2fe90e32e9aee5ddec8baa13de6aa9523d9a3b62d56f67f1"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1149/nuon-lsp_darwin_arm64"
      sha256 "c2b4cc83cd944421f43985d7bece9d10a52527ea59fc643f65375488bedcddb4"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1149/nuon-lsp_linux_amd64"
      sha256 "c5a0abd036a02106751e4d6f48b8e0c37a887e6435943022168a070bc1897666"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1149/nuon-lsp_linux_arm"
      sha256 "2ca0ee44fb24b48dadbc9c0fb99c137c36f2a4a92a15cab5920e1f3f64f694bd"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1149/nuon-lsp_linux_arm64"
      sha256 "d84fcdd9d733e08ca9e02ab460598f4251c141e72ccc2e4997da23ca29345d9b"
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

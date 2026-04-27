class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.898"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.898/nuon_darwin_amd64"
    sha256 "b155f61bddd1e79983095f2e668d5f78e3665ba9e0c2c0dd737430a24867e5b1"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.898/nuon_darwin_arm64"
    sha256 "e6d680b81cb006050a50c5ac6fcaf58e4b98e9d7a84710f7b977b926b9abe0cf"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.898/nuon_linux_amd64"
    sha256 "882c493dfa14d3a713a4a2fd95cdee8fabd79dee5d9ccb97a03c2451f62b620e"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.898/nuon_linux_arm"
    sha256 "7520b1b50042ede6b5941e7703510e3e7edce21feeba65bede19527478e01d06"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.898/nuon_linux_arm64"
    sha256 "804bcc6165bbcadb7ee6e8f2d7ba97edae0443489611af945533d92e4b6e9b9d"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.898/nuon-lsp_darwin_amd64"
      sha256 "8f6ce11dd3367a23f84e7a97aa01fda85c08320421ff00c74c79e683164e95ff"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.898/nuon-lsp_darwin_arm64"
      sha256 "c4192626ce58d71732913cc7b58d31b821d082e7b6dd4daeb6bfc9ed8e37b885"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.898/nuon-lsp_linux_amd64"
      sha256 "dc594627321d379ece820932a111f971d03ebf1985db1f5f0ed8146896e215a4"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.898/nuon-lsp_linux_arm"
      sha256 "7ca8657ccfba8a1aa05876fd48d455343c1083597a53589020044729f613709b"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.898/nuon-lsp_linux_arm64"
      sha256 "884d2a8385a054e56f28ae202a22e81f2a65675b8fc37421635e3f717c7492fb"
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

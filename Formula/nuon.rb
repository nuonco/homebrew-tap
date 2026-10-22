class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1257"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1257/nuon_darwin_amd64"
    sha256 "710375e97618e20fba3aecae449c4ba6c14bf74bdbff9009aa030a9d983ba56b"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1257/nuon_darwin_arm64"
    sha256 "0433a4a6bbee2a73d938d011c0f30628530a3627aaae8751e21a81ca45a7440c"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1257/nuon_linux_amd64"
    sha256 "36d2ca62d7a880409f12b42b1d2b0ad906d6461b5960caaffc09dc92959ecefd"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1257/nuon_linux_arm"
    sha256 "8ea77ca0547d93400b1cdc3c78d529ba652bce4394953e30b5a5dc023d2a787d"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1257/nuon_linux_arm64"
    sha256 "91520ab8c35618c99411ad1e86119563056065dfe0dccd1952ee3fd5ee290130"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1257/nuon-lsp_darwin_amd64"
      sha256 "154475607c51be1849c0e4bdc07cda931b1fff9d7492a1061aa0814e1cbe9719"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1257/nuon-lsp_darwin_arm64"
      sha256 "e0522e2851c154c17069d7beb6d2ca4b6dbde3f10f99319e0a6f7c90998bb3f4"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1257/nuon-lsp_linux_amd64"
      sha256 "875f192e4a761be13d02e9fe3b392b3c6164ac478153e77ef7459c541cbef0d6"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1257/nuon-lsp_linux_arm"
      sha256 "354eca70947041774b14224103c06914297308e3315f81cdeb61886dea6d2ca5"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1257/nuon-lsp_linux_arm64"
      sha256 "db5fa745aa63885a7e72d2938d0e91592aaee17155be5ba551b5f49f2423d1cc"
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

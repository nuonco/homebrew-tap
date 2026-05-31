class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.983"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.983/nuon_darwin_amd64"
    sha256 "bdca6d2857e785ab59390d9be52fbc48fafafe6dd298dcceeae333042670ee41"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.983/nuon_darwin_arm64"
    sha256 "3f73d6a643a8fd7f33e345d29ce531e482cdc4fe36471322ee6d7a6bdd0a2487"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.983/nuon_linux_amd64"
    sha256 "82b1f7c3e46b2e0852786ffd3b8ba3866f5249c83ef656e144c0e3fd1cd8b6cd"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.983/nuon_linux_arm"
    sha256 "0f2d5613d36e986d9dbc647b1ef2196740e2f61253fa2c93528f1daf35bffe93"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.983/nuon_linux_arm64"
    sha256 "082ee40d36cbc3779a7ede2ea11f1c6b0a3c1576eb586d369b1d756956f2d760"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.983/nuon-lsp_darwin_amd64"
      sha256 "587f8b0139e4c77856c7680419f56edffa278b877a310f96158fd2a88acd1dad"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.983/nuon-lsp_darwin_arm64"
      sha256 "c474c8d5c8470608b1de96a653989b808b06eb20cc8648decb508a372555e288"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.983/nuon-lsp_linux_amd64"
      sha256 "5af55971642caa29a957d1f7147632c6f08d59c41aaabbb2d52a1ee4ce2fb042"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.983/nuon-lsp_linux_arm"
      sha256 "8f8a87ef08ce498c079e70d5c89def3dc2b14d501380a8fdefefc59f76ee3d64"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.983/nuon-lsp_linux_arm64"
      sha256 "2bdbb4ed7f827c80cdb30f45f6bf054c77dc2b0a0c9ed52eb5ccdfb7341b6b73"
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

class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1249"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1249/nuon_darwin_amd64"
    sha256 "aec1ffcb4471aad04b3bfb4bb5c459110eedb9018a0bdf1bcb756a5baec74410"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1249/nuon_darwin_arm64"
    sha256 "419724c29b7f50e96887d14a45f8d0aa8fd8a9bb7142c3d89146443bdd156be0"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1249/nuon_linux_amd64"
    sha256 "e76218778adf2fa868ceebb65d00a39b0d7237cc8df849211e0d171959ccf3b4"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1249/nuon_linux_arm"
    sha256 "d1000daffe18f956dde68f255ae174ebb5fe95ed4ee4157955641821bc098a0a"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1249/nuon_linux_arm64"
    sha256 "382dba65962aec6f9460b10d903ce9bed46a1a64cea81e149be483bd4aedb3ce"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1249/nuon-lsp_darwin_amd64"
      sha256 "6b9b3ccbe1c83738a30814c7927d493f30851861bb951b588a948ab5cd09b0a4"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1249/nuon-lsp_darwin_arm64"
      sha256 "bd8ebddbbb38e14d96ff00feb7d95ea06930b90b0bdc018d5e214ff882e22541"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1249/nuon-lsp_linux_amd64"
      sha256 "10b46bd0252e58dd59d09561663380e4ff2f397d01d373831c85ee9bfd930324"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1249/nuon-lsp_linux_arm"
      sha256 "c8e30988f8c3327d282d52d3290e0df52045f25e1c1f01e5adf51abf65a3482e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1249/nuon-lsp_linux_arm64"
      sha256 "950a6b0c2f41bb929eae63c3ab4c7fd074a1d9b164299bc4fa0ca3fd0eac7913"
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

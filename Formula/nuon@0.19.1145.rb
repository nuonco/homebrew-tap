class NuonAT0191145 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1145"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1145/nuon_darwin_amd64"
    sha256 "18f523f0e7488da4a687f3c99c5d38988f03a73490718672ff864e352c253b55"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1145/nuon_darwin_arm64"
    sha256 "01116bc8a5c6ade021e96f80d415b82cbac2d98d311f0d5b0760817fd4e99429"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1145/nuon_linux_amd64"
    sha256 "d1a09f28d2c999ef4af8107d6173ce24f6ef6bfcf9b353f3f22cca9aa4df636a"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1145/nuon_linux_arm"
    sha256 "ea05d00250a33b0c6b38f091104be1f9918fd2790275655b88006b2e3cedd3b2"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1145/nuon_linux_arm64"
    sha256 "8e4bb2ffe06bd1a673ba57116a1d83461b63e626e39a63ae41fc7642f752af5e"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1145/nuon-lsp_darwin_amd64"
      sha256 "22698712a02be9cc16c09e3bc62a9d51c330fcfbc30828033d6c2670e59d9b32"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1145/nuon-lsp_darwin_arm64"
      sha256 "eb255ba048f33396b0d04ca0c4901fe9ab4712f04819e7d9a0fdc4bd34e1a61f"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1145/nuon-lsp_linux_amd64"
      sha256 "21e37798482212b97ecc7f5d87f8c091bcbc5bc0b0cad3ca4870caa1cd1cce21"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1145/nuon-lsp_linux_arm"
      sha256 "98290b741d3babd457c22b230c94861990555ffad35c67b7d44c5ce11c46af29"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1145/nuon-lsp_linux_arm64"
      sha256 "d818b7509ed6bc2f16069cbc45c140922375da7fe003cee6afacb0e9df98de7f"
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

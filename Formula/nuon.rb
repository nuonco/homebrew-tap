class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1039"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1039/nuon_darwin_amd64"
    sha256 "dc9de40b01afa2a186b812452092da7bb253abd8c120da7aabb75acb214ee801"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1039/nuon_darwin_arm64"
    sha256 "1c44bdd45f601aef5da8ef255c06bb2cd9f811e25a0b090950edff90519b0ce7"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1039/nuon_linux_amd64"
    sha256 "aa2796c6beded2b110fcc6c4fd689e48e36668c4b09c1283d241474f946bfc1f"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1039/nuon_linux_arm"
    sha256 "dd46448c1d18e55a8525085ab0bf725ab50cf1dd3eda66b8178b98369b44ce0c"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1039/nuon_linux_arm64"
    sha256 "bc29f6111e68c8bc816bb4f406fa498efaad30ccf82a0f0d393d5ed664ab0ae4"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1039/nuon-lsp_darwin_amd64"
      sha256 "cfd8715474286dc7a430942591e1187c6c7ee2325ad921677a017df3e4b16baa"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1039/nuon-lsp_darwin_arm64"
      sha256 "d4706a7de544fb8f2a5e1e4dae01462cad132d7d7498edd3282bdc3614cbeb3b"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1039/nuon-lsp_linux_amd64"
      sha256 "10163a311c14453013a6d7619044fe58b2436f58d66824ebc465723cc6cf80da"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1039/nuon-lsp_linux_arm"
      sha256 "0747ebcb34579f22f28a10d0d6320f32ea9431a0c7a722a6be09f65a7715c81e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1039/nuon-lsp_linux_arm64"
      sha256 "9ae25718c32cb19b33af6326131e09f2a7c34b9b95b8484cff33a7c1cb9f85a0"
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

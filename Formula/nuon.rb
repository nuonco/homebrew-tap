class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1040"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1040/nuon_darwin_amd64"
    sha256 "897a9dac63996eca764f9d73586c0b86d5dc35f5b05d1a8f994da9c6603f9c85"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1040/nuon_darwin_arm64"
    sha256 "68d129d126e2105c6836e6f2f0b0fc357336062e7a8dfed76774b90771b957b2"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1040/nuon_linux_amd64"
    sha256 "6053ae0a84931d3af60d9830f5c6d803eeb97c8bd6a21644f72b476406662928"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1040/nuon_linux_arm"
    sha256 "09e60ba7df8ddae5d07f50aa79b634ee47d64c377b9b32e5b1bab72f53460b76"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1040/nuon_linux_arm64"
    sha256 "ee634a99ff97de90e5300d9b74900e402f07b3df4dd02a34c35b68c12f01cd32"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1040/nuon-lsp_darwin_amd64"
      sha256 "cfd8715474286dc7a430942591e1187c6c7ee2325ad921677a017df3e4b16baa"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1040/nuon-lsp_darwin_arm64"
      sha256 "d4706a7de544fb8f2a5e1e4dae01462cad132d7d7498edd3282bdc3614cbeb3b"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1040/nuon-lsp_linux_amd64"
      sha256 "10163a311c14453013a6d7619044fe58b2436f58d66824ebc465723cc6cf80da"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1040/nuon-lsp_linux_arm"
      sha256 "0747ebcb34579f22f28a10d0d6320f32ea9431a0c7a722a6be09f65a7715c81e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1040/nuon-lsp_linux_arm64"
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

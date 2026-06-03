class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.989"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.989/nuon_darwin_amd64"
    sha256 "3ca7fc11848ef82ba217b665c6107d1098a2f90feaf000b3cefb17f6f39cfc54"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.989/nuon_darwin_arm64"
    sha256 "7f68de10e546f94301df50ac006e5c3ee778bab5d4c2e0ada172002cfe74526f"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.989/nuon_linux_amd64"
    sha256 "abc1dfa9eabc0330bdd34f987dbbef19ff72a9127ebf2fc78154aed945e51cb9"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.989/nuon_linux_arm"
    sha256 "0e87f2fabfe00646a5af6bbe0dec60cf5d74e9066ce27c97923a0c94bc6cff9b"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.989/nuon_linux_arm64"
    sha256 "55cc5df15dc42fc83b80742882723593c275339cd410eeb27dbade4c929c7fff"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.989/nuon-lsp_darwin_amd64"
      sha256 "d7ffc965d347c1f930e2736fe2754fa1d51ebd8eae6d5c9b33b969fe9157e43d"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.989/nuon-lsp_darwin_arm64"
      sha256 "19b8fc0394f56455a66df8fa0b4d178788a94f09fd71d7af8f4416f4b32c049c"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.989/nuon-lsp_linux_amd64"
      sha256 "2708a6afca748cd50a70015c030be3d39c0e663fe437d0679f06a4a7bc771993"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.989/nuon-lsp_linux_arm"
      sha256 "bfc96d3a33b41aef08f25555d1fb3cc5bcc5e13c5b966499fae573d827336c9e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.989/nuon-lsp_linux_arm64"
      sha256 "de857c19537d375b5df374c2297f9b54c9e79f978128d2039d9399cd032cc7bc"
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

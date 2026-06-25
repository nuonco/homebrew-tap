class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1016"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1016/nuon_darwin_amd64"
    sha256 "f32c833d7e0b374e9ede39ace4c52be4f00123ad7a1bb686579d8f08f805160a"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1016/nuon_darwin_arm64"
    sha256 "376e2560fa2974cd5e73e24c2c5a97a5c559f916afe4666887002eceef9df9db"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1016/nuon_linux_amd64"
    sha256 "a53aad9678555e4ceb3b7fcf2318ada001a4bf7c8f2afc6af556a0a3c157c8cf"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1016/nuon_linux_arm"
    sha256 "62c6022a19e21cd9d8a20a907cbac8a8554ca318d42f47f365fed93a30beab9b"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1016/nuon_linux_arm64"
    sha256 "197eb4d864395bad3df2bec3bc1d352f5495ef6c7f5b048c936097c4f3d6ba8f"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1016/nuon-lsp_darwin_amd64"
      sha256 "1c878f87e084a77d7190840f579b6c13a5baa69a3c8bf1085af1ee3693f99b1d"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1016/nuon-lsp_darwin_arm64"
      sha256 "78f7485e4ab6ee3156135670cc8b5e6d79ae86c6f89a578eea80bcd3bd091c9f"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1016/nuon-lsp_linux_amd64"
      sha256 "94960250348540b5ff9021879a5aaf9fe6f8d8606f8b116cdea78280121d8d79"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1016/nuon-lsp_linux_arm"
      sha256 "ee553e394fdd49cc468615862e50fe2b0c14dfb0aebe4ae8a685d3609ef0bd9a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1016/nuon-lsp_linux_arm64"
      sha256 "f03428d72aca605e9299508283642f60f4218c9986290813af3232b0c137915a"
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

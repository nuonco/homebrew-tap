class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.951"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.951/nuon_darwin_amd64"
    sha256 "1e26921ede3ecdc052173d6f411ba204f7f112db0d073c62c735ba7c639375a9"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.951/nuon_darwin_arm64"
    sha256 "0fcaa77fdf17276ec5e1b8745bade15eeacffbfb87023d745bb02ab01cd50ab6"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.951/nuon_linux_amd64"
    sha256 "871aa76dc0f9eab336fbe9043c2c87f28cc1397e9a8b31f4af3aa9844ae9ee71"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.951/nuon_linux_arm"
    sha256 "e2f518a6a907468a0770daf5f496e0769fdc466513fbdfc5c78b3ec320f42e2b"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.951/nuon_linux_arm64"
    sha256 "65a6605de137a6668055f54dae89120a489f5e73f9b6dc889632e330a758b45f"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.951/nuon-lsp_darwin_amd64"
      sha256 "0c5aaaa4fd779acf54cfc98b734aebd2c44b8ad3ac23a1936ee8db2096d0ebd8"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.951/nuon-lsp_darwin_arm64"
      sha256 "15889ca4311cd73e4c1f0ded3a43c3deb5b637f78ea26ac64de01df401de4496"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.951/nuon-lsp_linux_amd64"
      sha256 "cf4702218e91b9f6b86bd514fc45772e9a6858427357635c8c29f40c002b3cea"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.951/nuon-lsp_linux_arm"
      sha256 "ce99cc03eb0595cc2de5def48d72fc12de13025b1b97f40743c43d506a5df41e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.951/nuon-lsp_linux_arm64"
      sha256 "9a0a14df42a573309f4f2e6ff5a981ada07cd5760f164cbfd5ea1f6218a41371"
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

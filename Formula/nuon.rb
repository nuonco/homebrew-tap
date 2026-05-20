class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.958"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.958/nuon_darwin_amd64"
    sha256 "e0f9bad035ccaab7b419c5d88bcebb79b11eb26205b5da0f2ff066edd0425fc8"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.958/nuon_darwin_arm64"
    sha256 "fa45d653bd520b94de6b8eafbf945ff2bab000db2a2be45649c021a4761bd28a"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.958/nuon_linux_amd64"
    sha256 "2cecc5e00a7b8e69c8a4f35ba3ef104adc4fabfb572312dee153c490f9d7508f"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.958/nuon_linux_arm"
    sha256 "3fb2f26a314ae663f839cac01a478b04fa5cb866ef6a2391e2cf3b008726d4c2"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.958/nuon_linux_arm64"
    sha256 "3506918baed551be5c35c5b08bb32a087cf461087d3091d2cbd5982b73c64f80"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.958/nuon-lsp_darwin_amd64"
      sha256 "0c5aaaa4fd779acf54cfc98b734aebd2c44b8ad3ac23a1936ee8db2096d0ebd8"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.958/nuon-lsp_darwin_arm64"
      sha256 "15889ca4311cd73e4c1f0ded3a43c3deb5b637f78ea26ac64de01df401de4496"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.958/nuon-lsp_linux_amd64"
      sha256 "cf4702218e91b9f6b86bd514fc45772e9a6858427357635c8c29f40c002b3cea"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.958/nuon-lsp_linux_arm"
      sha256 "ce99cc03eb0595cc2de5def48d72fc12de13025b1b97f40743c43d506a5df41e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.958/nuon-lsp_linux_arm64"
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

class NuonAT0191192 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1192"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1192/nuon_darwin_amd64"
    sha256 "17e1d28fc6dc098d8a2e1de3094413de807fdf62d5f89dc89bf728ee8464fe5f"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1192/nuon_darwin_arm64"
    sha256 "3e7590a7f395ddf1c8e728e00c488f545dd9852393d323416675a7199310cf5d"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1192/nuon_linux_amd64"
    sha256 "3ecc0ae287936f16de56f89593cee0d5178eb99d409df24a03c9501e055be145"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1192/nuon_linux_arm"
    sha256 "446ae2076b63afd9bd3d1984e016b250be53c74ee2f139658cfebb0274f2efb0"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1192/nuon_linux_arm64"
    sha256 "bbe3e96be1a649a57dea0200c442ad711933a9e8334e83bdf25ee2b1fb57edc6"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1192/nuon-lsp_darwin_amd64"
      sha256 "4970347d2767b12f14b4efb98b4169ddb5a40c8db91125688e19c52f5a84d042"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1192/nuon-lsp_darwin_arm64"
      sha256 "60c32fc54665e76908a96592a47dc9e434b8ef0d08077ee05a2f8c5a34196414"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1192/nuon-lsp_linux_amd64"
      sha256 "c0c3bb67098d90054c187f97bda76907931d6eb5e021f00c17cb84cf7565bfcc"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1192/nuon-lsp_linux_arm"
      sha256 "3fc0aa77f5b590ce83d3cc5298b5780b9be839816b6e20c11277be971bb76878"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1192/nuon-lsp_linux_arm64"
      sha256 "4551648b93a2b588a279ca8e9db0c41de7db1077a8c60adef558c62194494902"
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

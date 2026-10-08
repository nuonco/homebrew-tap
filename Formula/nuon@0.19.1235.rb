class NuonAT0191235 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1235"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1235/nuon_darwin_amd64"
    sha256 "95838da0afaa5de19e6601d883e0d551b99aa3fc33f6a298f8eb52f242cf81cf"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1235/nuon_darwin_arm64"
    sha256 "38fe218085176b68f23b47bf6dd8bf3d657ec22284482426e5923574c6e3ced2"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1235/nuon_linux_amd64"
    sha256 "0a33d3dee3b534a3365e087d6ae393a57a9c9aa64471e769e6855240e13bf644"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1235/nuon_linux_arm"
    sha256 "0921e06d0b615ccced0064f754128632757766736288f665227c2453bfc842a7"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1235/nuon_linux_arm64"
    sha256 "1bec8e809c6a81f230892585f57820cfd0fde86e9dbb80072cec5d6cc41a48a9"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1235/nuon-lsp_darwin_amd64"
      sha256 "79975ee4b852b6228499ecaa0eab46b15919bca62e293eb45a778c4e165b6ee6"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1235/nuon-lsp_darwin_arm64"
      sha256 "62b31650c9fda33ddd81c48d981ff3582e47119bacfa9fa79bd6005d1f0829ab"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1235/nuon-lsp_linux_amd64"
      sha256 "5bbf589e745d7ee66457a9143e551ec2c5c14a9d577677536bfc7d29cc4c124f"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1235/nuon-lsp_linux_arm"
      sha256 "bdc21dfa97ffa675d7ca201b6b557b2fb4262c4edb6353016a7c9007e75a7072"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1235/nuon-lsp_linux_arm64"
      sha256 "0362f17837f37f4613bd82c712cafe4aeafb071648cd576440f7029d2ccf8569"
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

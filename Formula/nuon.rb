class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.912"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.912/nuon_darwin_amd64"
    sha256 "0ea13604703cd5b37226f0665e8b302c1b2e96bb2c94ef3f7ad66db763fbf49e"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.912/nuon_darwin_arm64"
    sha256 "a1762f78fddd79dd58d8c45c0726151ad67834cd834d033ab88a123b21104b0b"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.912/nuon_linux_amd64"
    sha256 "2ad397095ad92a98aceb60f00d514f9bf47a4f568667e922554732b26b29eb1c"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.912/nuon_linux_arm"
    sha256 "df1a1ab6edf9e65bdce709a4912c10e61aeb8ae4b77859b5097830019ac14501"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.912/nuon_linux_arm64"
    sha256 "9358a029405f6f49d43602cf25c22f5371f9b0cc83a7f0a0756a6f74a22eb6ee"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.912/nuon-lsp_darwin_amd64"
      sha256 "d7c3ffb1ed357c9e2937fd05a9687d25ae883f52252e6810e0316b42de67f1d2"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.912/nuon-lsp_darwin_arm64"
      sha256 "1b1d6767caaf877b58c943d1df42e8bdf098f8d31950a02624268887b9856db7"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.912/nuon-lsp_linux_amd64"
      sha256 "8265bfbd306d10b0f0c7a052e393d0a970984a36881c10c308723e961b775cfa"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.912/nuon-lsp_linux_arm"
      sha256 "63edfb2d2d0d03bbb92de6c6d5023b379ad772ddbe3e3f0ce1f1d0b6787b4453"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.912/nuon-lsp_linux_arm64"
      sha256 "2dbf2f427dccee40258190f4102e32b9acbd91796234df7a3001b63dcb71eb34"
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

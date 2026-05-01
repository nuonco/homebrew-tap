class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.913"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.913/nuon_darwin_amd64"
    sha256 "c1f1ac6111b19cbe754f99937550aa3c335b91567ee4f17b7d1a46bdd3964e8c"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.913/nuon_darwin_arm64"
    sha256 "516763c60bf86550c3bd28134487375e720b76ef22284f26e73f8ffaafa8398f"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.913/nuon_linux_amd64"
    sha256 "35f0ab2e74578718f963329eacbc0c37f15a11a728be6f3f7d36426e3eb7eb25"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.913/nuon_linux_arm"
    sha256 "e3b18215ff0681624dba917942de4e12bf87a80ae39bcd93b4c29082a817d952"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.913/nuon_linux_arm64"
    sha256 "fa9a9da11d7dddba887ac33bf08e320252121f383e14dff4c3625e7636d36f9a"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.913/nuon-lsp_darwin_amd64"
      sha256 "d7c3ffb1ed357c9e2937fd05a9687d25ae883f52252e6810e0316b42de67f1d2"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.913/nuon-lsp_darwin_arm64"
      sha256 "1b1d6767caaf877b58c943d1df42e8bdf098f8d31950a02624268887b9856db7"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.913/nuon-lsp_linux_amd64"
      sha256 "8265bfbd306d10b0f0c7a052e393d0a970984a36881c10c308723e961b775cfa"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.913/nuon-lsp_linux_arm"
      sha256 "63edfb2d2d0d03bbb92de6c6d5023b379ad772ddbe3e3f0ce1f1d0b6787b4453"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.913/nuon-lsp_linux_arm64"
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

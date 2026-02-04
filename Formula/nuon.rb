class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.765"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.765/nuon_darwin_amd64"
    sha256 ""
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.765/nuon_darwin_arm64"
    sha256 ""
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.765/nuon_linux_amd64"
    sha256 ""
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.765/nuon_linux_arm"
    sha256 ""
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.765/nuon_linux_arm64"
    sha256 ""
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
  end

  test do
    system "#{bin}/nuon", "version"
  end
end

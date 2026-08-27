class NuonAT0191143 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1143"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1143/nuon_darwin_amd64"
    sha256 "4906c1313e8578fb5abd9a0d4a9d0224324b44fc498a896c34733bd1beaf0d51"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1143/nuon_darwin_arm64"
    sha256 "93e73f465953d1aa116c8961e7997a709c148e6fadc779bd5aa79996b35bb6fa"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1143/nuon_linux_amd64"
    sha256 "9b963522b97fa4521cbef16e5bf7107e04a5c24220a006f0d235e26a5030c91f"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1143/nuon_linux_arm"
    sha256 "01b9faee30abdb31659d3f992354d0e3bc5dbe80406f90e36165f322407fa659"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1143/nuon_linux_arm64"
    sha256 "d627b46147e15539c548faa14e3c7f3dc15d67286f8601e3ab28b5414b3be93c"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1143/nuon-lsp_darwin_amd64"
      sha256 "22698712a02be9cc16c09e3bc62a9d51c330fcfbc30828033d6c2670e59d9b32"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1143/nuon-lsp_darwin_arm64"
      sha256 "eb255ba048f33396b0d04ca0c4901fe9ab4712f04819e7d9a0fdc4bd34e1a61f"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1143/nuon-lsp_linux_amd64"
      sha256 "21e37798482212b97ecc7f5d87f8c091bcbc5bc0b0cad3ca4870caa1cd1cce21"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1143/nuon-lsp_linux_arm"
      sha256 "98290b741d3babd457c22b230c94861990555ffad35c67b7d44c5ce11c46af29"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1143/nuon-lsp_linux_arm64"
      sha256 "d818b7509ed6bc2f16069cbc45c140922375da7fe003cee6afacb0e9df98de7f"
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

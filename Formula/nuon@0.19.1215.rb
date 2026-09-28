class NuonAT0191215 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1215"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1215/nuon_darwin_amd64"
    sha256 "89a41d0a046531a2a680a129704c4510631c0f0825a55a155a3c15769cb2351a"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1215/nuon_darwin_arm64"
    sha256 "f9c03ac5679aca3edfaa1035f86e34ea382398051f50d3ed0d53c48af3a9f575"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1215/nuon_linux_amd64"
    sha256 "0c694646278ddb0c3f18c2bb8cf1ced8ec72010f3a887f66300297a2a09b0e2d"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1215/nuon_linux_arm"
    sha256 "14b453972a5686ecfea1b7962c281b3b63e2d1dfc9e61301279490c22c29e409"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1215/nuon_linux_arm64"
    sha256 "ee65c21db76985f55bcc327b39daee8e87050b6f3b8a6004dfb439feb77305dc"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1215/nuon-lsp_darwin_amd64"
      sha256 "f7547fca065a181beb3264bac9038d2d84486ade3bc1671dfbbb7d63279116c4"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1215/nuon-lsp_darwin_arm64"
      sha256 "be806acc567c49b1040c95b6244d1e62afe907dcd83f72e9f967da7a14432c0b"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1215/nuon-lsp_linux_amd64"
      sha256 "b22cfecdf636dd4806c6d756816b2833da32ed827d6b8c2dcf1f9be69350c163"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1215/nuon-lsp_linux_arm"
      sha256 "1bf998eecd356d9b0744c0f86a3acae60d298bae51b2e0be69e8d11614ea4e1f"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1215/nuon-lsp_linux_arm64"
      sha256 "9a60f25071800844ecc6c844e46a0ce7f85d17b0d65aa5aac3741b544ca0ed27"
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

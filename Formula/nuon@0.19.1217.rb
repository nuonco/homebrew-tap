class NuonAT0191217 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1217"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1217/nuon_darwin_amd64"
    sha256 "df22be0bf7400ea5e0a4ea547db499cf956c0e60434b8497df161f322833b145"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1217/nuon_darwin_arm64"
    sha256 "396f7c24edfad34b10b3e0729935fc7bb0e5782dfc86fd1fc9e2f0efd0c1de4d"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1217/nuon_linux_amd64"
    sha256 "93d4a8cc818c6cd04719d6e079203221fb252f70e1a7588b26a546ba4e587f8a"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1217/nuon_linux_arm"
    sha256 "855b287d19843f5bf0fccfe8ae07a412e423b69230977f650c2e0da35dec57ea"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1217/nuon_linux_arm64"
    sha256 "bf97aa7d9629366a064aeb367ee7c1876cff06f898321e9d31cc33eeeefd2a81"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1217/nuon-lsp_darwin_amd64"
      sha256 "7dc4eca2a274d5bcef483edf80c36900cce8cec1ea570d47c9e3841330d529c1"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1217/nuon-lsp_darwin_arm64"
      sha256 "6f4634c074eb3ca9ef287924831549828bca860f163ec13da459e863d8c23c76"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1217/nuon-lsp_linux_amd64"
      sha256 "b2df4bdad61bc418aa398872a5bc60942cff273373f6198e3c75698c7ca92b83"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1217/nuon-lsp_linux_arm"
      sha256 "3a1d67f46b73be208049ed97d75f82eb655c21ad5c48329dde7829aaf2076a1c"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1217/nuon-lsp_linux_arm64"
      sha256 "42634d430e0e97607be12fb2ebe8fee753951e8a17273cb5d6b5ba1f3ecffa4c"
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

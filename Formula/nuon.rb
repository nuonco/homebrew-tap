class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.990"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.990/nuon_darwin_amd64"
    sha256 "064882dc5b8d495a753d77d4f20936277086ab441b028352fa855e8ce94151d9"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.990/nuon_darwin_arm64"
    sha256 "dcf386bc621657c1d7ba3f905a42a7af69654515e9ac818a4a041768bf4b2edb"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.990/nuon_linux_amd64"
    sha256 "398a46e5e3738d2b8c71a516e15551f0d5a56333ad2a95e1f628b84707d4dd80"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.990/nuon_linux_arm"
    sha256 "a1a84801cec7ae96bf28d0fcdbf6dafcbf0bd65523d091545c7faec6548d69c6"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.990/nuon_linux_arm64"
    sha256 "38d6cfc6a23141c747278ffbc58e3f060d7cc788b7a17efed713bb25c99858db"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.990/nuon-lsp_darwin_amd64"
      sha256 "ffffbe18f3f8b25a76dd5326498a20a0bd9de906c112db42736bb04f76770c40"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.990/nuon-lsp_darwin_arm64"
      sha256 "02a1b0e21c8ce587e9951bee176dbdf42c3eaef319e49f05876b93689d9f17a9"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.990/nuon-lsp_linux_amd64"
      sha256 "e004d9faa5c52105ebdcb000d102649559c9793aac87913671a32a7f74e506da"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.990/nuon-lsp_linux_arm"
      sha256 "5799d135de1d7b86cf7b659762143254b33c042454ae10114ba8fa234895f2fe"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.990/nuon-lsp_linux_arm64"
      sha256 "22fd04bd966b8e99d530b50e38e5ade0c02d5ca2c1d7925734ad6effc1a641bc"
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

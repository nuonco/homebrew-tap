class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.932"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.932/nuon_darwin_amd64"
    sha256 "bfa8f4eff79528fd77894fc0b7712c69d5a3fa96546c143c7d4961a3bcb8531a"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.932/nuon_darwin_arm64"
    sha256 "d8f7e2deb7b9e5d5ef584af2146f762d3f84b4b962b70c7de9e2be2411b85929"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.932/nuon_linux_amd64"
    sha256 "34dff5f58e7e1f77ece7bbc457e4489077ef82470dd2fbee5e636d4c63d86abb"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.932/nuon_linux_arm"
    sha256 "96a41b913c2c8e996c7c13fb08e941b74bf66a9f90d8807987ed8b1af1761ece"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.932/nuon_linux_arm64"
    sha256 "1c3364fac8778d30dd0760d43f555fdd7d7dad76932883d432ee003a5c9a2d96"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.932/nuon-lsp_darwin_amd64"
      sha256 "3e8cec675632bf0e37353051cf75ed275323e5f78ec1a23a4bd5e4d0b0b2126a"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.932/nuon-lsp_darwin_arm64"
      sha256 "d5361bfee236ca1b1ede93dc94de2c2d2a2624a686e8000e8acd06ea8d388db4"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.932/nuon-lsp_linux_amd64"
      sha256 "3eccba4db5ff9313bd5b213952465ddfc36172bbf8ebf0a7825d05dc11fc56da"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.932/nuon-lsp_linux_arm"
      sha256 "0d1be776c08c78d86e209e47a0ccaa35315810e7cb06387e8d5d4e9d48ca30c3"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.932/nuon-lsp_linux_arm64"
      sha256 "fae62335777945169e1961a43130f72e38e459c3198fe8b68fb0728d711b15de"
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

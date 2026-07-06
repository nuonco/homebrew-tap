class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1041"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1041/nuon_darwin_amd64"
    sha256 "f9379ef2545dec3c7e4fdf41eaa6f280d246d5126288b96c4caf9bea58c9e420"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1041/nuon_darwin_arm64"
    sha256 "083b50ee00a88ad0c355b8edfe043f8dd0754216ca73e5a38e23f133f8147d65"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1041/nuon_linux_amd64"
    sha256 "822b0363495811748ecec8f18d7b0529f9f2f600e80489b110597c958c573f33"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1041/nuon_linux_arm"
    sha256 "91e1e73e7bb7012c5669b8d9f1f7971432f8e451d8842d312b3a40664e0eba95"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1041/nuon_linux_arm64"
    sha256 "ac5bfee8e4c7578888eeeda51771c93f6e36e1ae890b31a6258095418d0f3525"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1041/nuon-lsp_darwin_amd64"
      sha256 "1afe6b707f8a5b77c28f53923761dfdcc88782c6663ee5fef145d797eb0baec0"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1041/nuon-lsp_darwin_arm64"
      sha256 "254309446d7937b2201a260aec97e2a229e93f4af632166728c23f204265375d"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1041/nuon-lsp_linux_amd64"
      sha256 "c6f16ba5cafb073a2458b59503d84dedf603996cde7485eebbc601accb35a8f9"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1041/nuon-lsp_linux_arm"
      sha256 "87242b7f75f8f99f905e9291dff78db45e7199b33d5c3cb92a59c18649379a3d"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1041/nuon-lsp_linux_arm64"
      sha256 "e71d49ad58b2a493b550e13446a54331e627dcee3d7b42cf2735f38178cca524"
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

class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1043"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1043/nuon_darwin_amd64"
    sha256 "f3387a79bb6c589c42500f1c8ad3cef6e8a41dc21ae4423a1d3f88ae0784f26c"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1043/nuon_darwin_arm64"
    sha256 "4cb51c8ced592f6eeb4e005e8b857e7d96afb2edb4a8581f1e335d650bb63665"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1043/nuon_linux_amd64"
    sha256 "1affa938212aa23d299d366e50b7d424461b348e0f65cdcd4c811378a7ca64b2"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1043/nuon_linux_arm"
    sha256 "d34b4bd3c9318662533eb1c51d5884699b88cdb7a76d8ee0fd567ea74e33d0f2"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1043/nuon_linux_arm64"
    sha256 "054cb7ff0aae66cb1e3adb64fbe9f54f6a6c8e7f01125186ab9a19bbf68b0c9e"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1043/nuon-lsp_darwin_amd64"
      sha256 "1afe6b707f8a5b77c28f53923761dfdcc88782c6663ee5fef145d797eb0baec0"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1043/nuon-lsp_darwin_arm64"
      sha256 "254309446d7937b2201a260aec97e2a229e93f4af632166728c23f204265375d"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1043/nuon-lsp_linux_amd64"
      sha256 "c6f16ba5cafb073a2458b59503d84dedf603996cde7485eebbc601accb35a8f9"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1043/nuon-lsp_linux_arm"
      sha256 "87242b7f75f8f99f905e9291dff78db45e7199b33d5c3cb92a59c18649379a3d"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1043/nuon-lsp_linux_arm64"
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

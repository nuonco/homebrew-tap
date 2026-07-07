class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1042"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1042/nuon_darwin_amd64"
    sha256 "29783f7c9812f58ac7dffb12824aa104134f4d0027f466767960f8dc5344834b"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1042/nuon_darwin_arm64"
    sha256 "9a11afba551acd8014ef7486d8b95af7047fde892ca0338e2ecaba1137c4f589"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1042/nuon_linux_amd64"
    sha256 "efabb44c012b7855403210812aade9fe2dd0e005763ea328f35d28be5e2087bf"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1042/nuon_linux_arm"
    sha256 "9626376099d3e4840bdbd226212101dcd5eaac11c67ddd9b0a1ba836d94260ed"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1042/nuon_linux_arm64"
    sha256 "b3d68daef7a1ce74a746c079dda165c405a7d369af23ed5f7f8afb6a271eae80"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1042/nuon-lsp_darwin_amd64"
      sha256 "1afe6b707f8a5b77c28f53923761dfdcc88782c6663ee5fef145d797eb0baec0"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1042/nuon-lsp_darwin_arm64"
      sha256 "254309446d7937b2201a260aec97e2a229e93f4af632166728c23f204265375d"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1042/nuon-lsp_linux_amd64"
      sha256 "c6f16ba5cafb073a2458b59503d84dedf603996cde7485eebbc601accb35a8f9"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1042/nuon-lsp_linux_arm"
      sha256 "87242b7f75f8f99f905e9291dff78db45e7199b33d5c3cb92a59c18649379a3d"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1042/nuon-lsp_linux_arm64"
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

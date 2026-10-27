class NuonAT0191267 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1267"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1267/nuon_darwin_amd64"
    sha256 "f9dde1f2ebf6d69f13772ae5fda1adf073caba0146627439f913bd0f50d7feac"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1267/nuon_darwin_arm64"
    sha256 "8bff49d6d005e4570055b9de94ad3ddeea6bca8ca76f878cee14c359fdd18727"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1267/nuon_linux_amd64"
    sha256 "9e7e3a5cc93846deba9a611a2dc4f1da71e0fff15f80e60c969d52624ae93f53"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1267/nuon_linux_arm"
    sha256 "1382e4410c726b33fbb30e9d8e6034518c83e36d40909f6d68b810b74ee1bfa3"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1267/nuon_linux_arm64"
    sha256 "db5f1cf9c27599cddce2503de00610659cd23e6d7ad9cdcd1d1dbfb2eb6f21bf"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1267/nuon-lsp_darwin_amd64"
      sha256 "d7c795e3a81c077cb258b3a1ffa2032f8b052bd53e2e5e10641756a99b0b03b9"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1267/nuon-lsp_darwin_arm64"
      sha256 "8ec95cc8307be17d51d106d93fe01e1cd8611705c6edab5295ef9239c83e602b"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1267/nuon-lsp_linux_amd64"
      sha256 "8de55426e17f102985a1dc75ff33a31a721ebdc3b63c68ed4795a5799f651842"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1267/nuon-lsp_linux_arm"
      sha256 "995b80c2f90d60639e922cae764c05074742c6337b6cc8cd1557d454e5f22c59"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1267/nuon-lsp_linux_arm64"
      sha256 "b433dfaaa7659ca13b7a6aefc4190ab8f786a341f669f89fd505e502d738d21f"
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

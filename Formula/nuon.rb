class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1268"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1268/nuon_darwin_amd64"
    sha256 "07f3a016c7941fe87be208ba2c6b5fe955ef52cdf17c8e2b7e1e29dd666faa50"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1268/nuon_darwin_arm64"
    sha256 "ed0b0cf16da6fddf8417433775d4f97d1ea31a693f6af9203e753d829ea15222"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1268/nuon_linux_amd64"
    sha256 "4a388fc41913e6e9bd3a1ecba787860072d62942b671410a3571423ec8a241c2"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1268/nuon_linux_arm"
    sha256 "8d8edcfee3d743e82afc4803806bbafd097139117d8822ef3088277f1f5136c2"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1268/nuon_linux_arm64"
    sha256 "3086d65b96126786f8d51a6acc83432ca625c3c9c8e509b8f3bb1ecc8d860555"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1268/nuon-lsp_darwin_amd64"
      sha256 "d7c795e3a81c077cb258b3a1ffa2032f8b052bd53e2e5e10641756a99b0b03b9"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1268/nuon-lsp_darwin_arm64"
      sha256 "8ec95cc8307be17d51d106d93fe01e1cd8611705c6edab5295ef9239c83e602b"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1268/nuon-lsp_linux_amd64"
      sha256 "8de55426e17f102985a1dc75ff33a31a721ebdc3b63c68ed4795a5799f651842"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1268/nuon-lsp_linux_arm"
      sha256 "995b80c2f90d60639e922cae764c05074742c6337b6cc8cd1557d454e5f22c59"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1268/nuon-lsp_linux_arm64"
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

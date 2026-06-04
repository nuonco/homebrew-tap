class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.996"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.996/nuon_darwin_amd64"
    sha256 "7b2db37d23271883828eaf18fc90f9d7bf1d73e41c9614056e34c363a4eea62c"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.996/nuon_darwin_arm64"
    sha256 "15ce042fd3f822de82daeb97a6c64679eb9f93ba9f3d0219f2f3fb4074674bd3"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.996/nuon_linux_amd64"
    sha256 "5907f95c79281d7597390d34b749908dbf2833cc053070d28de8f65dec518036"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.996/nuon_linux_arm"
    sha256 "2d902ccfdfb15a7682211a3d1f870ca5aebd76ba89ba89d1370b2ca763f06de7"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.996/nuon_linux_arm64"
    sha256 "9a68cbed0b2b5047a8f9bc16ed3d37b0775eefa0cdd7cc0d6eca0e79914ec03b"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.996/nuon-lsp_darwin_amd64"
      sha256 "1fcb915e96a7738eaa537dc3682337661e24d79202900056fd58455dd1c92c19"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.996/nuon-lsp_darwin_arm64"
      sha256 "4037d26e21a9be8509948f213fea258349ef3f097da4a7a34b399195ecc132c4"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.996/nuon-lsp_linux_amd64"
      sha256 "5691d043f3f0d74faf882244387f8eb0d38df81f4591f55a07228e3da6605f3a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.996/nuon-lsp_linux_arm"
      sha256 "45ad065401cc0ec094bc35c7a1a29065850ca6d7a575983b2d23739bfbd4fcd7"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.996/nuon-lsp_linux_arm64"
      sha256 "4f0d7a57c91634cb44db6f7ed88ea1d37776da37484f693dcc15b80530ba879d"
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

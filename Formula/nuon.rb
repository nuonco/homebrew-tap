class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.992"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.992/nuon_darwin_amd64"
    sha256 "8dcc8fd7efba5373ddc543dc09819cf9f2efdbf1d3e6ac23e4d4ddf1b9716a4a"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.992/nuon_darwin_arm64"
    sha256 "b5bc9e812f644f73bed66c4d7d0b05d47b3b87ab425bafa8e1216eef004d0737"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.992/nuon_linux_amd64"
    sha256 "2d740a6810bc4ca5d709766803a9b7facc96a9069fcabfeab2e498b68804031d"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.992/nuon_linux_arm"
    sha256 "b35c24a8c7544f5cfa23151975055a00d587a798c363c183124655a8dbb0ca6d"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.992/nuon_linux_arm64"
    sha256 "44fa113e845251bda9482d013ea8ac659523302de4f7437906ad338ce0d95e82"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.992/nuon-lsp_darwin_amd64"
      sha256 "1fcb915e96a7738eaa537dc3682337661e24d79202900056fd58455dd1c92c19"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.992/nuon-lsp_darwin_arm64"
      sha256 "4037d26e21a9be8509948f213fea258349ef3f097da4a7a34b399195ecc132c4"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.992/nuon-lsp_linux_amd64"
      sha256 "5691d043f3f0d74faf882244387f8eb0d38df81f4591f55a07228e3da6605f3a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.992/nuon-lsp_linux_arm"
      sha256 "45ad065401cc0ec094bc35c7a1a29065850ca6d7a575983b2d23739bfbd4fcd7"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.992/nuon-lsp_linux_arm64"
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

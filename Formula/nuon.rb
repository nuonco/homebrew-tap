class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.503"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.503/nuon_darwin_amd64"
    sha256 "5437a6ae2676ff92ddc75168ef5a198c9b04b8892bb36d2aa90d9a2d76dc7ec9"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.503/nuon_darwin_arm64"
    sha256 "8a2ce4c5cf9cf04fde62fb813ef318fa3c9885711989dbd8111c3e4c59aa78ee"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.503/nuon_linux_amd64"
    sha256 "3645446916f6cbd443c6b38d0d20f377c3c28d174f484cfd64acc5b68a7e0895"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.503/nuon_linux_arm"
    sha256 "bf1ffa71e349fb4b5a91ccf0b0f73647c741f7f92b1f8233dbef3c010a8f7bae"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.503/nuon_linux_arm64"
    sha256 "7361e089a2cc30df38328e8ab46fceb811faa154314ac469df8946f31655c094"
  end

  def install
    # Clunky way to get filename.
    if OS.mac? && Hardware::CPU.intel?
      filename = "nuon_darwin_amd64"
    elsif OS.mac? && Hardware::CPU.arm?
      filename = "nuon_darwin_arm64"
    elsif OS.linux? && Hardware::CPU.intel?
      filename = "nuon_linux_amd64"
    elsif OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      filename = "nuon_linux_arm"
    elsif OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      filename = "nuon_linux_arm64"
    end

    # Need to rename the file because we're downloading a binary.
    bin.install filename => "nuon"
  end

  test do
    system "#{bin}/nuon", "version"
  end
end

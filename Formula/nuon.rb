class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.678"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.678/nuon_darwin_amd64"
    sha256 "341f3d7830f4693f54fa1fb85b4c2c2e37fec524c45a36e97af065ca5987ea32"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.678/nuon_darwin_arm64"
    sha256 "9abd5106cae7007666f384d6816b749b49d62bc1b0e01cd23b87a48c99b8a632"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.678/nuon_linux_amd64"
    sha256 "aba318c99dbe0b5620114c607885dc91d15bdb816f4ad5129a031a4c0084714f"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.678/nuon_linux_arm"
    sha256 "0eb0cd1dfd608ae16eed6709512a1376d82f6472bf0a8a7238ba2106f1f0b1bb"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.678/nuon_linux_arm64"
    sha256 "6cb22c7f5ddee8f75d42eb01ae365e8985f7f1ffab6d28929f1c6e57ab089f2d"
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

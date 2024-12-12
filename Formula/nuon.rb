class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.343"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.343/nuon_darwin_amd64"
    sha256 "2039a4e8cb97587a0f2a31369cdf84c7ba603cac9a644872339e86cc56b801f3"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.343/nuon_darwin_arm64"
    sha256 "58eb38c30570cef41ba8913f8bf0fda6c79d26c28a8edc71174c33b1a83a7bed"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.343/nuon_linux_amd64"
    sha256 "eb2395d9027ec756aa9b8d5f7e9db97625159c0e30b101d2bf325ffe813dcb1c"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.343/nuon_linux_arm"
    sha256 "ca8c9e95b2cf9d9f839499818329cf13d4fdd0bdca3c15b6eff0c981213b223d"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.343/nuon_linux_arm64"
    sha256 "ce97589a18452ded8fb0062fbc3245b3fddf1412e63ba33194d1d4e1d9426777"
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

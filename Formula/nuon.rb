class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.551"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.551/nuon_darwin_amd64"
    sha256 "042b53c501c657b7d6e2d2f39295bfb25214ef8f3ea869727bd48ced2affdfd1"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.551/nuon_darwin_arm64"
    sha256 "00f0c799a3579f1d7cb55409ffb797444b2de39d7ef68c6e7c9d4ed2c574f74f"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.551/nuon_linux_amd64"
    sha256 "bf49ab098d50b755fb10fa235e6303f70d54df03d65d02fd0a02a45e33154478"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.551/nuon_linux_arm"
    sha256 "a9ecefc068e0d95e5b37facb30d13d6b208d075e585f2092c8e76d0ef38a7338"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.551/nuon_linux_arm64"
    sha256 "72c6379f4ab8f8fb757eea0d8677b3943364b39f6a077576e84aceaa0dac1ccd"
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

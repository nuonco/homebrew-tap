class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.486"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.486/nuon_darwin_amd64"
    sha256 "c89d86f877f88d00d67e40be944c2279862a1cb273a1ddd742fd60f76d672de8"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.486/nuon_darwin_arm64"
    sha256 "64489d457539cacdb0bbe4a2848fffbb94643152cd68122e2e6538a22f9f046c"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.486/nuon_linux_amd64"
    sha256 "a6d4e87dac61e4ab782bf013ce7e8827687d47dd1e657ec6e7e355d5f65d9b15"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.486/nuon_linux_arm"
    sha256 "4463d3453aedd42dc2cac6f2312dad37b26e38371e7001198ed1ee1eb7ac63b5"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.486/nuon_linux_arm64"
    sha256 "f18110c9ef13d4ebe0e32b9bffb64a12acac6f9f6ba45fa1ea1612042e31783f"
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

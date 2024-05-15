class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.122"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.122/nuon_darwin_amd64"
    sha256 "8d1ba9d1fb6ff8f15a9162fc2e96f0b0646b23a8f7e08fd8913885d7e0cc9060"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.122/nuon_darwin_arm64"
    sha256 "7ee4df93e8955b4ba474ff8d65fdd556e2861dd91131c8140c9475c321339f58"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.122/nuon_linux_amd64"
    sha256 "9e6dd964a589c43b8ae06597424b2918d8e9c0d14d46e28663a2217bfc544671"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.122/nuon_linux_arm"
    sha256 "c46a302c488f49745aa2b3ff5bc2f40ecf03252445f4388317340302c8aad29e"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.122/nuon_linux_arm64"
    sha256 "65d3ad43f0b8938027322a67ae40ace3673d2ad65b3b9cd48c3291c5dd842ecf"
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

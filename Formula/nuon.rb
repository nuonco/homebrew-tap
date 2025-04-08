class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.517"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.517/nuon_darwin_amd64"
    sha256 "d8ab6145b9e00c5b6c504af62531ee91988094da33e88bc9d1450951e2a74d0b"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.517/nuon_darwin_arm64"
    sha256 "8f160b501e6fa78d6d8034c4185fc2f119387f1be09c47d2b59eb58d0cb0ce86"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.517/nuon_linux_amd64"
    sha256 "dce7909ab890b1cc7d628269bad53f6fd604e15db5f708f8dcb56f5ccaf9101f"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.517/nuon_linux_arm"
    sha256 "38c4d9dfc5f0ea44a30add77d2a0c16d3820ee538dcb0c98c4769ca51aa16a0a"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.517/nuon_linux_arm64"
    sha256 "22806b46f9552801bc6f65d2345e44f9cec9b47a0c9c7168f910e5fb0f9291e1"
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

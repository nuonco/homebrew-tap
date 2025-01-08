class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.356"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.356/nuon_darwin_amd64"
    sha256 "d8c802272c55d55c9b5f33e4cea23be2595b8ceef080138ab4b270859e63aed0"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.356/nuon_darwin_arm64"
    sha256 "57ae16adc21ebd7b7dd1cbd14afc8046ef9370e1cdf11a8e80766db033a4cc9d"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.356/nuon_linux_amd64"
    sha256 "9978d90a5c4fb10c7a3d22d21576aa80d29b5f6864ea11437176d6a1ffbc4268"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.356/nuon_linux_arm"
    sha256 "4ed9177b6b48d966ed511a174c30070b3b4bdeffa8cc80f728060b6bb7d19b33"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.356/nuon_linux_arm64"
    sha256 "9b73a7fa396760d96f2ee66733b273a9ea601add4fd9f9634f9c8578d3ccbad5"
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

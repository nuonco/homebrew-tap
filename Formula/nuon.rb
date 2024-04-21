class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.105"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.105/nuon_darwin_amd64"
    sha256 "e38de5f3f792a61c42bbae9f696819315e31914672eac49e4e7f226fd5392a6a"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.105/nuon_darwin_arm64"
    sha256 "1d80067f31adc9d02bd6f83c1918949548adc375e1c6cd20448c2f693fdb8b6e"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.105/nuon_linux_amd64"
    sha256 "2a8d8a88cea6b7f4dab7be7d82e8e10293dbce128a6fed463b03b2bf98a9a0fd"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.105/nuon_linux_arm"
    sha256 "36d0065a4ebc2ef75ac3c455887cd87635162a2f82ca1b0b9fcdf1810730f48b"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.105/nuon_linux_arm64"
    sha256 "5efa313a4b0a3a6eefb8d06a30962c5c94a4f0a5f3d25ae2545e8cb6df73cee6"
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

class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.619"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.619/nuon_darwin_amd64"
    sha256 "4219a3812301a945ad866a3556d8dba86b8ff0787623c16a95e6b53a6f35c697"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.619/nuon_darwin_arm64"
    sha256 "01f9f1a77673f9c6244aeb4a0c6a29fb3a56b17651ecc70214498b1e4310d0d6"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.619/nuon_linux_amd64"
    sha256 "d4a28a61e6fd0bef1bf9e88d70bfe77d36165010ca78c42534d6050dfb6a2afa"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.619/nuon_linux_arm"
    sha256 "b8a7d41c7444e07f2fd6ff22c63fc935b82cbcd68ddb6711e374f037c5e1ce7d"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.619/nuon_linux_arm64"
    sha256 "42828c2299b04b5a4896b958d4c96406a31564d90255d2c32125be79d9c57de4"
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

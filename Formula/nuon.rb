class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.144"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.144/nuon_darwin_amd64"
    sha256 "7f6a18fd71428c40098d46eb87f9de7e9322d20a0a3fb169fb845200af75af5e"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.144/nuon_darwin_arm64"
    sha256 "bf28c80d29e832c26d8b1fdf6f6e58059f14886c358e93d4e3c7a4eb45f3e802"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.144/nuon_linux_amd64"
    sha256 "7e59c1c09e9a3f2aef5b7bee7633aeeb6c4c8ea26739b58a423179d1492dc1ee"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.144/nuon_linux_arm"
    sha256 "838a1fbb97641a5bc68b81082d340a99098eb1a1b345a01c1b94d5a008974eb9"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.144/nuon_linux_arm64"
    sha256 "1f9b010c7af591552209b40fe2215fea4ff2d453b9ef681f0a2b5dab9e7429bf"
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

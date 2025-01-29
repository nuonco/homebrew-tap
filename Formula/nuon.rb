class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.383"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.383/nuon_darwin_amd64"
    sha256 "8141cbb9cd3e07d43e84f578570d4e4b19624ddf0e25c5cf333843c7957ad3eb"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.383/nuon_darwin_arm64"
    sha256 "b81b2ac91eb0b24dd749f102c78ea278311f0e53328721c316db9abb0e886977"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.383/nuon_linux_amd64"
    sha256 "ddcb7de9eec0ba527f04cb204c2afb1a0d405b8f3c0d01bb72b691c6ffac6eee"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.383/nuon_linux_arm"
    sha256 "f3445a6aeae2a25d2ed4f81a88f7fe975ea271df69b09dfee00558a42a70c03e"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.383/nuon_linux_arm64"
    sha256 "1bfea0ed4d23370d1fefca72ad0d4e328e88963c1e6fe7c435c45406ad2b075a"
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

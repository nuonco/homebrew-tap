class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.99"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.99/nuon_darwin_amd64"
    sha256 "a6de80aaa2dbe62dc87c9471ca21bec32c9c9d8122f8266d92e793e6500350c0"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.99/nuon_darwin_arm64"
    sha256 "54cd4bea7e6846bc8ad17d7f8a3a516557fa449360ee2b6d4dbc244f2fb653af"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.99/nuon_linux_amd64"
    sha256 "e76b4f95059301a97f0b7905c573ccf8c4da90bf2d15417a57bb0659f4454c5a"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.99/nuon_linux_arm"
    sha256 "606e11aeec2633d8b6c4234764058bdc959880b653c1b51442fe00d1ca48afae"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.99/nuon_linux_arm64"
    sha256 "058c0f868b43dd241e66aaf167f39c7eda954e7ca0fdf07f7052a8684cf45247"
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

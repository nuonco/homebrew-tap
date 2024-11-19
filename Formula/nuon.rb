class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.309"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.309/nuon_darwin_amd64"
    sha256 "dea47947db1a7c5d532f8620ab54751098cceade1f6b243a9e8d0e7840eb6e67"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.309/nuon_darwin_arm64"
    sha256 "e5870a34e10ba2bfe638e2a9f9d0b1d13df257656e07f1f7f548a027e176a1a5"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.309/nuon_linux_amd64"
    sha256 "570947ac97dd0b1f2d401e7bf92eba1a4c1d6cec2f0c1e06f7f649a80e541661"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.309/nuon_linux_arm"
    sha256 "323f420f630562b0a67e697a73aa0abab7df41c9c3cd9045fa15c5ca1dbb6249"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.309/nuon_linux_arm64"
    sha256 "6537e5e606a4cf8763aaf7e2703acb5a98a39b802c99bf7acd66507bd36d8937"
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

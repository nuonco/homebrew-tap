class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.532"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.532/nuon_darwin_amd64"
    sha256 "81726da2cf5fd1fceed2e9d9cf30fd0b8c9a3dbc58d0965b6449d5b7841fb080"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.532/nuon_darwin_arm64"
    sha256 "db41b43dc11a56e6896011ca5c1c93d6c241f273f9795f2dc0cb50229ee245f1"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.532/nuon_linux_amd64"
    sha256 "566c8bf19fc4793b121dc9b86e045d113843036ef316a6c5b649e9eddfef2aef"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.532/nuon_linux_arm"
    sha256 "b1a5084e060e777846c8ee8b49b541779575be74d1c565dcf7e06f2b3b148f01"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.532/nuon_linux_arm64"
    sha256 "59b37b177ccfb639a9b198ffd1ebdf37cd2df28efe78d6004da1e329a17ca511"
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

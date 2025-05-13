class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.554"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.554/nuon_darwin_amd64"
    sha256 "8513326ca5de8bb282fa6d7a4a811bcb287632e74add56d7d3efeb7bb3f74ebc"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.554/nuon_darwin_arm64"
    sha256 "8139e23b1b4cbc4de68fc79fa5120fa4416646cca473baa166dc941f11bd74bf"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.554/nuon_linux_amd64"
    sha256 "b29116dd4bd6be209c6bd3188dd2873c309b61a0b6c8e0c0571c5985d17cce2e"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.554/nuon_linux_arm"
    sha256 "d7bb3d37e2bb94d9e2ee3215c5beb6f88ca1750d2e1554f06b9cdb11ebf30cf1"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.554/nuon_linux_arm64"
    sha256 "f49953a2b9b7a1417d56f85efc93dfcbd80cab75d6f28d21dbe66c609501f7f3"
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

class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.204"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.204/nuon_darwin_amd64"
    sha256 "caa2b164710b2bb3595112364d49125dfaa279237ba3a52c2808083f26e974a6"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.204/nuon_darwin_arm64"
    sha256 "f64c6708a58bb6c9e0f7b0c1305af16cabd5d6773b40930eeb731ed8bd569bf8"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.204/nuon_linux_amd64"
    sha256 "589ac43295829baf64fc7c98d19b179a17e323272a9a6b7c93df8aa45534f9e1"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.204/nuon_linux_arm"
    sha256 "3dde90ee634997cbbb42be548a0f6b37a8b1018e30443ec5f15e0f49f5ce1c74"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.204/nuon_linux_arm64"
    sha256 "ba5a2ec8a1b5143ac39f0e392d56878440745d3ea9b1943b5bb5e9d0da1dd677"
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

class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.82"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.82/nuon_darwin_amd64"
    sha256 "94118b8d40c8c82f8883dc95b0f1e250e1036ddcbe34b9f3d8784a3ae9d2475f"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.82/nuon_darwin_arm64"
    sha256 "a5f273decf79b714cd5204609e00ed2dc692916b538d1d7ba84a9eb0fa616e80"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.82/nuon_linux_amd64"
    sha256 "b6727751afa9fe301a1483004d111d43b30ab6139d8507dc71cf0b2e53300b18"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.82/nuon_linux_arm"
    sha256 "9baa742fb0d07efa9f7651e67f72ccf750ea6c0ca4ae7d5b7d24897d39ac15cb"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.82/nuon_linux_arm64"
    sha256 "1fbce510667a0ef2172fe1de00112d0d4c7d93207ebe045a621c6808ede37ce0"
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

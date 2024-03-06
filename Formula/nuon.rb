class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.83"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.83/nuon_darwin_amd64"
    sha256 "01f91ff44d3432441908d79f2c4db4145920296776170c5bf03aa23bcbc3c579"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.83/nuon_darwin_arm64"
    sha256 "e2bb053d37149a5f04bb5cd1d41fa15e412d363dbe2b6d5bd75141790eed3e90"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.83/nuon_linux_amd64"
    sha256 "72ba9f0d04fb5eaab13ed9af62a5d6664afd27d4d2f08d9df1529369aa12be18"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.83/nuon_linux_arm"
    sha256 "11a2b198b55da3c9259366e1fbecac6ae962b8aac86915beef4447bc9c7bb576"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.83/nuon_linux_arm64"
    sha256 "36ac1144cf1aa5c2b746a3d33a1f0d990cc262d826e4e7e0cb405a896ff6404f"
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

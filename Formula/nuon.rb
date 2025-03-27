class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.501"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.501/nuon_darwin_amd64"
    sha256 "aa42b5b1f5c050f6967cbd085e167c4c185fbd01a789ce71640b371931a22c48"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.501/nuon_darwin_arm64"
    sha256 "05abb0d6140c69d2969a07573ea7714e3125996ea9fe74dd91fad4aa71e821c9"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.501/nuon_linux_amd64"
    sha256 "9e0605b0a2d3b2d9ed06b0d48543079d2c77e6504ae0e1539b2b23d4fb16ceb7"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.501/nuon_linux_arm"
    sha256 "2454026d17712138af2edfd2af080c135313e5fc6fed0fffaa22b17eff3d8ff6"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.501/nuon_linux_arm64"
    sha256 "f2914a90dd5a5b5e3daa0f72bcd98fb6f9569c337fec88f3c2ca8924b19163b2"
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

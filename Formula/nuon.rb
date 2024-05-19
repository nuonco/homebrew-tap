class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.134"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.134/nuon_darwin_amd64"
    sha256 "c08f40631d1250c3f2f6f7594da3e57651c43eba0df2b6119a27342f2ad82c85"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.134/nuon_darwin_arm64"
    sha256 "232beb353f38c68b738fab21a7d96e70967a4342d2f40bebb78f0bdef0ba2c39"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.134/nuon_linux_amd64"
    sha256 "7dd24adbe3c608df4fe879c384040d8528f0e6a7b4292476c7f64bf57cb88256"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.134/nuon_linux_arm"
    sha256 "ceb92ee5f65cfeb221bcb05c4dc0612d873255b49f93a0d4f55f0e4174ec0e3d"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.134/nuon_linux_arm64"
    sha256 "7aa5e02cc7b392961b365eafd3378b80aeeccab25aacddb5b2b18b35491d502c"
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

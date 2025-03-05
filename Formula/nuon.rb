class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.463"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.463/nuon_darwin_amd64"
    sha256 "120c0ec9107fce31b18a1b9af1978a4ebe66cec0874c1fa8c1d056255adeb6e4"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.463/nuon_darwin_arm64"
    sha256 "036a511e3d81d5eb280d46a318a61ef24879e7d1a499fc956ec02f3230ae73a7"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.463/nuon_linux_amd64"
    sha256 "ed457bfedfa0446f5121d52e9bae1431a8ac1a1f79a7f3db1f0f2f4e4836327d"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.463/nuon_linux_arm"
    sha256 "51646d66f39949efd3eab6cad1c464a45647867fd10358ee2872a3dc5355d286"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.463/nuon_linux_arm64"
    sha256 "cf2b6650e3c4ba656cf250ae5053e0dd932277bd128a64794c67f422cbecbdce"
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

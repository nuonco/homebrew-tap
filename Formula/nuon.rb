class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.71"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.71/nuon_darwin_amd64"
    sha256 "591dbae02c3f41fbd5374867d7609f396b47eba69940d68f08f8be74d38611b4"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.71/nuon_darwin_arm64"
    sha256 "50ec2bc86a80c39450f83a00142a60ac73e70bdbf84b0738d72df3da14b39d1d"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.71/nuon_linux_amd64"
    sha256 "69ebd5c9b7a492a40fd500dce62b15479d12d4585cc9fa8afdb1cbcf452d6627"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.71/nuon_linux_arm"
    sha256 "87bb410c8eb7117bdeea859e43a0a9531d28fdcb461dfe73eb59ce62e6a7281d"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.71/nuon_linux_arm64"
    sha256 "7c91f34e9a4d3536c4a6d4b5119b6c0ebcb19780cf60d208ea823d5c8bd8c84e"
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

class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.194"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.194/nuon_darwin_amd64"
    sha256 "aa7fa516dc2bb9a18e7a8b0df5373d9ab1ec48c16eeddd584d76a905b0c8dbb7"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.194/nuon_darwin_arm64"
    sha256 "4184d7cf39ffe4ae3c55b999c94bc1af8a46278acca7e88e38a1cbd6a04b758e"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.194/nuon_linux_amd64"
    sha256 "d18e304abf03d77d178b1751efaacfdede2666bce5c5d99bc62a6646d29f1da2"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.194/nuon_linux_arm"
    sha256 "31d8505b0cce40a46d4af14f56281fbc4d5f37cac6acdea466138a049aea6fb4"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.194/nuon_linux_arm64"
    sha256 "22376e8fa6610b5604c0a7ae14a0add8cd99c3c6ac1239a5e905b1fc4f338580"
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

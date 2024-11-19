class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.307"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.307/nuon_darwin_amd64"
    sha256 "0c0fa413c54553b5fb76a7d799b6a89a16890143b1aab1f9ba2739e497427fb7"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.307/nuon_darwin_arm64"
    sha256 "8935c78b9a2cc8b6fef89b7b78aa385bbebb0612ab4e3d7b75380300109c966b"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.307/nuon_linux_amd64"
    sha256 "7a5d4c7d1e868079541cea7e47a4028a4781c4ce41136ebec11ae2ee89b99fb2"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.307/nuon_linux_arm"
    sha256 "d69afbbe58006dbd462d51ae3fd9c35739fe7cb1d2e6df86bb69b2cfe5e2806e"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.307/nuon_linux_arm64"
    sha256 "ce8e9ad8b51f66b75f46eccb31982b4a786dc6e6f6f1b66904f14d852b8202e3"
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

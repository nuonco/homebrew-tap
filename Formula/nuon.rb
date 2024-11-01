class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.268"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.268/nuon_darwin_amd64"
    sha256 "0b2cdc540f1f4e8113b4614ada2fb57dd9daa5e58a02531804fd29ea040746b9"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.268/nuon_darwin_arm64"
    sha256 "cb96cc5fd89b30cfd7bfe30bb0bd2f544de2362db5241711d1fdeae520d9430f"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.268/nuon_linux_amd64"
    sha256 "2c3e015a500140c1dc1de1345189678ba63d3f0ccb2ca596c29e34a9651dfe97"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.268/nuon_linux_arm"
    sha256 "b03e6eb0a4613ce7ada4ed7a4351acc4a43cf095998a39168a82b15aab636784"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.268/nuon_linux_arm64"
    sha256 "f7aa6622ea44f233bd41f35a6a523ae3390d526ed56d72b25b58d467deb6a91e"
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

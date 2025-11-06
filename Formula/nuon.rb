class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.688"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.688/nuon_darwin_amd64"
    sha256 "bcae0e7dc212ea85881f4b6964f1bf8a148dc6205f0869e5e3eb3bf89356d0dc"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.688/nuon_darwin_arm64"
    sha256 "3bc69c9ce0c6c4b8fe0315ecfe8d93c36e3c98a158427ccc2fadc696fe27f973"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.688/nuon_linux_amd64"
    sha256 "d8078126b5e264ab37a6a1d75f577c9ebc59c0c9a4d2888bf3ee14822cefdf80"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.688/nuon_linux_arm"
    sha256 "598a9fcf298580e92c23392d149a64a3b0abc5d1c68d90e50ee5f965935a65c8"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.688/nuon_linux_arm64"
    sha256 "c7cd75b2b5455617e136af3a16d191abc14c71cdc0a1a33fe2cc37dedd209574"
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

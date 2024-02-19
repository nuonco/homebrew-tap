class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.52"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.52/nuon_darwin_amd64"
    sha256 "9609e7af7b711ba30b8352d1dcbbc9a17dff0bc38fffffef3919c31e65da1c28"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.52/nuon_darwin_arm64"
    sha256 "136b1688e57da3d52cb65efaf6678afe597800d2221fc73460a6ace9f407fe1f"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.52/nuon_linux_amd64"
    sha256 "d43c9f669c8dcbe9e083ecb5d622aa75f6e2ecbb736a83b333f21c690758b230"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.52/nuon_linux_arm"
    sha256 "bdf61c9fb7c0b789c2c8f408a8c0fcc12feebf003ae5cc267f212e226e2b6c5c"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.52/nuon_linux_arm64"
    sha256 "3a2d6d95b046481f131c77af9a12d832de2391d310a7ce73ac4fa215680dd626"
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

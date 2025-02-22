class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.433"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.433/nuon_darwin_amd64"
    sha256 "57ce17fec02cd7f7312322c787ad881da8fe5195ef09621edb2dd96c739ce448"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.433/nuon_darwin_arm64"
    sha256 "ed0a2e9c4734211ffe00a9f3f4abcd19c2684e20100c4552a82c19ead999ea73"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.433/nuon_linux_amd64"
    sha256 "15e1d0ddaff1ea166ea6d3904ca4d4ce6e5c35ad4680a4ab8e170792fc4991be"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.433/nuon_linux_arm"
    sha256 "722ff1579a01f81e72f42c9e25bb478fe92d6fadd636fb6a84e1bc294719db02"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.433/nuon_linux_arm64"
    sha256 "c8c87c7f38386646df0d70e11c522754ec8f65af7bb8556dfbb3b07f7cc41204"
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

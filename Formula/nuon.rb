class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.550"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.550/nuon_darwin_amd64"
    sha256 "e25c316d9f6159c5da48655e053939fd48dd02be96f28392b82c81020a73ae53"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.550/nuon_darwin_arm64"
    sha256 "5ee296d0b713db79d246a2d2a1034a7fa356f49c2a6b38bb71ef594ceb58ef44"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.550/nuon_linux_amd64"
    sha256 "5b88f4496fed1408f9f3215756e1aadd12e9827dd809f0a592cceba88f6ccb5f"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.550/nuon_linux_arm"
    sha256 "7e0a2f5a6708edf5af3e8623e9d2f612ac7b286e9819550a201c93ca91426d48"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.550/nuon_linux_arm64"
    sha256 "738ca431bda0c2671b57f41e9ca76f33f5c8aad99535accebfffefd1c0bae638"
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

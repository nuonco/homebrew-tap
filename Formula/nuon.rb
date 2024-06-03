class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.152"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.152/nuon_darwin_amd64"
    sha256 "19a67ad279368a689206cb9c0a1d1ee8e22c47ab8a90d10695f4ac4b59796632"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.152/nuon_darwin_arm64"
    sha256 "3f9dc7e646c259d8ae9bef41e5c01f53a6c652a3c45f7d776ddaee4085d828b3"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.152/nuon_linux_amd64"
    sha256 "1924875b3cb391e1afb0f26e7153fbb60df662c2d7767d14525723a1abc23627"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.152/nuon_linux_arm"
    sha256 "df85366587ec7bb3e8a92023c6bc8d83b3d317d46fb65f40c3cb68760fe35219"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.152/nuon_linux_arm64"
    sha256 "3ee5e421c607fdd492d8cc5bd21940b8b9d8b98ca51ea6dc21ce157b91ad7ee3"
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

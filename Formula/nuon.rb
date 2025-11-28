class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.709"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.709/nuon_darwin_amd64"
    sha256 "880924a9167f6a12ccb6d4deeb564d5f425fb626f5b0e6318eb7d254ddd18a53"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.709/nuon_darwin_arm64"
    sha256 "9652d427c41a6158fee3e9b0ac7fb555897deb05546fc2df41bf9ac15e1a72f6"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.709/nuon_linux_amd64"
    sha256 "5ad8a26ed9c6dc12b865f81ee4681fbc7a15079f614d062cb47d0f06a5c4ce57"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.709/nuon_linux_arm"
    sha256 "ce46370013366a92da58447c0b08ad5d9ff915523dcfba4db52217d518e42e44"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.709/nuon_linux_arm64"
    sha256 "d9780366da4e6eee38f12616121b4e85cfd43abfe9ca2664435cd8cf6016a2a4"
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

class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.666"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.666/nuon_darwin_amd64"
    sha256 "dd6fedaf93668ec417cc1fb50b1bb67d56c223e4351e3e57df90fa999c033da1"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.666/nuon_darwin_arm64"
    sha256 "74f18007f36d0b1d98a6de9018ae041d6dbbe05c31ab83f17b74de2be476910b"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.666/nuon_linux_amd64"
    sha256 "57d6f02872dffa2380265b7dc9233e0cf0d43bf4824215fb74e8741eed4ee135"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.666/nuon_linux_arm"
    sha256 "1d4d7db2e4cf516603bfa7ed161fba185fb5367eb5eed9062503181fef24f5cd"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.666/nuon_linux_arm64"
    sha256 "a31684ea1eb36cfbb2616bf6ae9fa0b7fa8877d2105f480ce998b356b5170fa0"
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

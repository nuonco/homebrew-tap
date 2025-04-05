class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.515"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.515/nuon_darwin_amd64"
    sha256 "086e971f38ea01be5ed1af975f6d146b7e9bbd1656f61581df7a69806dcd07b9"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.515/nuon_darwin_arm64"
    sha256 "4eaf660d2b81b2b36e3a12bfebd1d42ba6dff44f571af43053fd9e7d8725a26f"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.515/nuon_linux_amd64"
    sha256 "a99143e9bc2d86a03bd3fc5b08e89fdbb197a9d99cae517de79cbc4fb4569035"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.515/nuon_linux_arm"
    sha256 "0a061b3cfe165be56740d78cbf3c71db7b4748ca965a750d7b67103e361ee938"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.515/nuon_linux_arm64"
    sha256 "d868b9f41e6e0a5189a3c58fd7a037402cdef42f4678a7b7d1bcb27af5f55aef"
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

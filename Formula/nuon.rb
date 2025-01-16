class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.364"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.364/nuon_darwin_amd64"
    sha256 "9edf79361cd1be05013373fb45f41d77323d7cbc5d7aa2147b5b2bdd41b17bf7"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.364/nuon_darwin_arm64"
    sha256 "9867f455d5d68e44b2c6abc8b7e0ef909626504f9148bcd4aea17a3e69ba1420"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.364/nuon_linux_amd64"
    sha256 "46520892452857b92b223b1bc40c397ce92692132d43a7185bf656e9b24fec72"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.364/nuon_linux_arm"
    sha256 "3ec9f23f5a2e93dc47d56fa7f2e97f9f2b67c291da7ee473fee1ad22a0aae602"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.364/nuon_linux_arm64"
    sha256 "9504f0e9deb781d0c6ad6f5f0bae0cf9240695bc6b8c57ec8c55940a46eddf7d"
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

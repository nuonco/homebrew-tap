class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.133"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.133/nuon_darwin_amd64"
    sha256 "c7b23ed0c994ca9be60a06eb80d48f7c0a77755d1623b85afe8c23ed531b8ce1"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.133/nuon_darwin_arm64"
    sha256 "5b3188f8ed8cbb1eb67e2b2d88331e800374c26c95e285b0cb6cfa258e415c26"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.133/nuon_linux_amd64"
    sha256 "f1725a855e4512d4c5d7b4d37059560c16a6ec181156c0ce1389de433d4d5c78"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.133/nuon_linux_arm"
    sha256 "55d96d6300cf0aec8ecb47ca5721c192a71307ec4c592006fef8ee7e2273f7b2"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.133/nuon_linux_arm64"
    sha256 "5192d30a7d2040df827cf5bdfc113b2dcda586e81c89abda4dd27c6cbabbfd62"
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

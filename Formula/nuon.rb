class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.572"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.572/nuon_darwin_amd64"
    sha256 "2f55a5d07689c869a2cbb56eebf700f9eacbe7240bd52fc8087c989dfc77cd60"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.572/nuon_darwin_arm64"
    sha256 "c63f3884aaa1c21d8d1c8c2c11e05f6a4df5aa704e77fe3c9d89edc146f48f75"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.572/nuon_linux_amd64"
    sha256 "e3818dd8f6f0606f21f326fd60d98316c1a5e5debe96ec58c68d160e7916947f"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.572/nuon_linux_arm"
    sha256 "e4f2aad8dd6df04fd6372f96873c9a0383cf692e72678eefbd9cb98a8bfd9ed4"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.572/nuon_linux_arm64"
    sha256 "d04af64b2e9d1bc854f52b51eabfe014baf96b2bcbd76f2d1a05ab2e878fcc6b"
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

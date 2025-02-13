class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.405"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.405/nuon_darwin_amd64"
    sha256 "9ec60f15a624df5b1871a4bed9268333e57782dc97ca6865b04de5da066ddc9b"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.405/nuon_darwin_arm64"
    sha256 "21e5300f9ee972f01002f8a02636969c751d0f31d839a7e50493814c8d06cc2d"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.405/nuon_linux_amd64"
    sha256 "0da28396c9d1510d073f44641a38aa8f3180d45abe631d7d6c5dabbae22b8ff5"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.405/nuon_linux_arm"
    sha256 "9ec51027a3aa4e95c83f45aed1ce5503f8f44f174f1d88c2bebc9852ff5511e4"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.405/nuon_linux_arm64"
    sha256 "1ad800b20b017d2cbbca6e9970114dd61380aa5df8c0d8a0c6cd226329cf8105"
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

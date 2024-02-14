class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.34"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.34/nuon_darwin_amd64.zip"
    sha256 "4787f5a422439d3b277a889b159981e88049f48bcf9e41e70481620567a7fd9c"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.34/nuon_darwin_arm64.zip"
    sha256 "85cddfd303c45989f0948a70ae03bb30f66c6e6106383697fe85ccd739137ca6"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/nuon_linux_amd64.zip"
    sha256 "617042989ce46b5dd07772237b49b57b8f8e97b1604c9dbbd85ead87effb51fe"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/nuon_linux_arm.zip"
    sha256 "1a738382f1b9d1fd5238e1408db939768ce5ee9d5d2c6e0db1f29a68690afea4"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/nuon_linux_arm64.zip"
    sha256 "e9a8a2f676b51a5334d00a0c3695b24ca75e30f4f449eb191e304fedfa099565"
  end

  def install
    bin.install "nuon"
  end

  test do
    system "#{bin}/nuon", "version"
  end
end

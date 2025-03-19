class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.489"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.489/nuon_darwin_amd64"
    sha256 "04658ee41290c2ac8c1ae1938e0c20167428685bc7c4ce9afb772b7e38691212"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.489/nuon_darwin_arm64"
    sha256 "efe3dd56166c148e2bd8d4a584fd0e755c1a1f65e55ec1e27abad0f6db973b8d"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.489/nuon_linux_amd64"
    sha256 "aab7e19330dd1c070d8a74d6be55ae6185c38d7f61a24bc7b51d4ed4ea5bbe0b"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.489/nuon_linux_arm"
    sha256 "a7d8f23e49740b38295de9293307609180b1760471cdc705239a51a2ab717649"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.489/nuon_linux_arm64"
    sha256 "a915f212eb84e71d308e94a37fc57fadf81d0b3f4fc8edefa46ff8a3d7c36e6b"
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

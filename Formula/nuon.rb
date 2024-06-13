class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.161"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.161/nuon_darwin_amd64"
    sha256 "24ec18a8b65dda2c082c95c2ff805c9fd7e51bfd4fa041aa200d7ce84fafb4f9"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.161/nuon_darwin_arm64"
    sha256 "223ea0b7bb6ab4b90e80e281ff49dd3cef4e06c1db7fb98f1d2a0fe7ad5423a6"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.161/nuon_linux_amd64"
    sha256 "b1f17ad8a9bce810008eaa012a9804437a8f93c0a6ba7dcd12c7580353c8cfc2"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.161/nuon_linux_arm"
    sha256 "a01540e99f0c43e43cd359dc8ee54d822ea1596765ac378b62221c05150b3891"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.161/nuon_linux_arm64"
    sha256 "ec3e87a01b4440a9bacd3619d149b2b45fc982f734cbd60e0feb1aae4737b19c"
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

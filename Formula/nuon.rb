class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.397"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.397/nuon_darwin_amd64"
    sha256 "7f29c3df0bbb3cbb69ec30cef44a4db6a2fa46161bdc1b24c935fe51f24c4227"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.397/nuon_darwin_arm64"
    sha256 "7174fb77bd7581bf2cddc2aa36f36fd7507dc5d98f3782f1adcf360f05e10ddc"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.397/nuon_linux_amd64"
    sha256 "38bb7376473865a2c9de5057d76dba46573f8816d951dec19a8bc22f612c49eb"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.397/nuon_linux_arm"
    sha256 "9f6cafa49bc8a87276db68b3fa6c01f78a0c1372f9ff77cc3558b87ab617cb07"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.397/nuon_linux_arm64"
    sha256 "7e265bf86d8a3bc4d728e3ee8f66e4370a02380b35ba1cd0ebd59cf137125574"
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

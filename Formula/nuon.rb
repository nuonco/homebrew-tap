class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.263"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.263/nuon_darwin_amd64"
    sha256 "6a7c30147bf12a3447f6a3a42bb8f8abc51d8f6561520bceda3ac2760d4812a5"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.263/nuon_darwin_arm64"
    sha256 "cbffc868e2a397447849c90ffbf4198a49c6c87291f985309e9a134c5e6658c2"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.263/nuon_linux_amd64"
    sha256 "9a7aa704830ebfd7f206d9d8b4ae93d4eb66858aa04cf47561c3ac29ec78639d"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.263/nuon_linux_arm"
    sha256 "9cfd5239c6db6a9797b1d19f4508317fd9f62ac2b254d5100398cd2c5b0b3b75"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.263/nuon_linux_arm64"
    sha256 "5cdb2d2c585f93648f6090f12dd7c1b46bc711f7dac69e75f8921e4f189e64ad"
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

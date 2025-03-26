class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.494"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.494/nuon_darwin_amd64"
    sha256 "8551f1ded8d7e4bd4dfb29f8f0cfe037dac5b4a1fff549aa34867e28d7cc36f8"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.494/nuon_darwin_arm64"
    sha256 "cfb4c21bcbd266c6e0ec78455799e304341fb46128b9f7a988d6a94e2240d658"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.494/nuon_linux_amd64"
    sha256 "f6c86e4d34a2e364b0e95dc9666ca5c4b83c51a6dda798442ae640c54cbc55ab"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.494/nuon_linux_arm"
    sha256 "235ed9aef8ef45168d28da9816ffa06b45357edafbe4c5a6576fc97eb6c11024"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.494/nuon_linux_arm64"
    sha256 "fe0bb74dbc8dc4f611da316d4c8b2681a339b3809a5f31756b721919bda7656f"
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

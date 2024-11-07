class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.286"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.286/nuon_darwin_amd64"
    sha256 "a53db19ad2776276462820e48a661b721603517b5fbbe7495bd48d07dadbbc67"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.286/nuon_darwin_arm64"
    sha256 "71eec87bea6e7dd334d3191ce3010c8610b4bf2fdfd41c3c427cef10db0bab5d"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.286/nuon_linux_amd64"
    sha256 "a8665c1c3d9841bb59de8556ab3d41ffdccef1e317def81cb6320e9a41244696"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.286/nuon_linux_arm"
    sha256 "8088a744cb5c7112b33c2b442f1116cf476d0f3643bec8e6496d79987024c3ae"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.286/nuon_linux_arm64"
    sha256 "fe6ec67aa8b3d038ff75a8f923ea0b5ea8565af0e3c023d54acabfadddb1bd9b"
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

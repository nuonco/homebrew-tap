class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.493"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.493/nuon_darwin_amd64"
    sha256 "f6d4b5f7a3fd0296f8ed5f9c04d82da2e8812cb7876bd67e2e55a24dd262deef"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.493/nuon_darwin_arm64"
    sha256 "944b8d0502def085a59f1d53b0074d11d813818762f9a3b70cd962fd5b77d57a"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.493/nuon_linux_amd64"
    sha256 "121ba3c86ffab7650634587ca1eed7c5435b6de193e0c8848f04a3f6adb94489"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.493/nuon_linux_arm"
    sha256 "81cf8adf1d1c6980415a8a89867eeb4ab067e0ba440d5f1a7c807a6f383cab93"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.493/nuon_linux_arm64"
    sha256 "8dbc6f26e31c4f3a817ce85ed890c9da03a63e2e96758e09f9702f6d9ee5d753"
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

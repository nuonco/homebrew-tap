class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.280"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.280/nuon_darwin_amd64"
    sha256 "1dd3c9dfd07974bb9a456756d171fb06ad5f391e78da1ae4d7b44ff2b912b8a1"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.280/nuon_darwin_arm64"
    sha256 "66c2d301da8d6a7521abc788df2d809bf0def08bd289d995ca37581bccc9f0b9"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.280/nuon_linux_amd64"
    sha256 "d8c1b9056cc952b2ec855c73a7c166b46fff2ba580256732559bb05ed213a7ac"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.280/nuon_linux_arm"
    sha256 "d3e85cc86db3f1240a41b639f9c27c12800f2f65b6eb7567898c530e4e9d87a6"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.280/nuon_linux_arm64"
    sha256 "438d44839f2e966d90900f195b8fc7e1b1c95f4ab641219d71e77f248ec641aa"
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

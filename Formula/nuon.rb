class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.198"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.198/nuon_darwin_amd64"
    sha256 "1b61c7e5f8bd6a0534a3f99cc7d4ceea601032532ba60cd054427ca4c93d2ef2"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.198/nuon_darwin_arm64"
    sha256 "e1ca7381f103f11a5009da3ddddcb7fe2a30d0ca8ba03f1f1f79835846871766"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.198/nuon_linux_amd64"
    sha256 "f99730223505eeacc99cc0ea04f965d21bcdfd8f588ee10f2b49038f8b7e2c04"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.198/nuon_linux_arm"
    sha256 "bc175cdae89a3e38db5b2c7bfab6a7ba39f72b49c3929caf3c5f7c2305c0d6e7"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.198/nuon_linux_arm64"
    sha256 "fe5c73f07e8c152983a9ef8745fe702abc2fb8778a804cc7d84f8f7f6881eb98"
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

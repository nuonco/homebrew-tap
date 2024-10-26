class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.265"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.265/nuon_darwin_amd64"
    sha256 "348414c44050457ab5b11529e2b23c2ac20946fba8f9743159a31d5b18f9a632"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.265/nuon_darwin_arm64"
    sha256 "665514a75fe8815bb7bb775eabf2c66877056f28580157edb4387c2fdd0930f9"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.265/nuon_linux_amd64"
    sha256 "724c947c24abbcad577c00aa62847a3f3d3ebe41d5bf5dfea9af8a7fa86b9332"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.265/nuon_linux_arm"
    sha256 "a7731bdaa5b1db0fd7691f9ce46c84a9cb093c6da7095ec26b8cdd87857cdee5"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.265/nuon_linux_arm64"
    sha256 "71494d2165c4e5207d510299bdc8a1c8d3a8fdbd8f8c1dd4e90635e33354f0d7"
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

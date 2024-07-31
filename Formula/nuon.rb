class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.200"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.200/nuon_darwin_amd64"
    sha256 "df56d7c21152917c1ff76dbbfd0765fb9f0ca6d3807a8c241216bbbbbefa74c3"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.200/nuon_darwin_arm64"
    sha256 "88c48c3cf0ae832e70c36bc32bd5367feb6d64bb5043d7131d4aac18cf3216dc"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.200/nuon_linux_amd64"
    sha256 "3f48b56ffc5d08d66ebbe348a6bfa0e5335255db66726c33dedde5274eba5edb"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.200/nuon_linux_arm"
    sha256 "ec3202416fe75e12111efcd7828e8216c36cce915da20c08b16d2a3dff78d432"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.200/nuon_linux_arm64"
    sha256 "2c24a98c6c3b05bd04662269249d1aa2e4f290cb02ca7ba979711e17e32605dc"
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

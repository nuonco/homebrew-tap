class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.176"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.176/nuon_darwin_amd64"
    sha256 "8654df904d60d9e464e8021af1c3bfc211c3d823bbe93cda15215df73f5c68b7"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.176/nuon_darwin_arm64"
    sha256 "c104b5abc4bad62e37b371d2c2fec29a65ee0ef82ad53fc2a655233bbfbfefa3"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.176/nuon_linux_amd64"
    sha256 "409fa29dc3c6d7053c862ed4dc52016b989323aa550fdeb6ffd3696ef56d92a0"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.176/nuon_linux_arm"
    sha256 "0770f56637bcf99e11014d9c12ba8b947d9429ddd87d782b20bf4c67da15b4e5"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.176/nuon_linux_arm64"
    sha256 "44ffae7dac361520c0b97063637b43a005a7e709ac8c89c3f89932a1aef4d002"
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

class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.66"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.66/nuon_darwin_amd64"
    sha256 "ef9551b5048ab33bd7eb8eab2fc19edaa5ad6addd06e3520fc4ff64d6089e520"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.66/nuon_darwin_arm64"
    sha256 "a5c32789a3eb8840b2c083a4558d3a18a7e5182968343258656e32a0eb84a225"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.66/nuon_linux_amd64"
    sha256 "d07d0ec4821526a8820d0b3c290df4380a160e2f2faf4e0a72e67c0ad3b616c7"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.66/nuon_linux_arm"
    sha256 "dae9c5e67b00f112c49aca5e53fc772bd0d97fa8dd8d151bfb781a1bb36080fd"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.66/nuon_linux_arm64"
    sha256 "5a5bea0ddb9d5689d30f31db2be1260d6f8d14f9f0415c32d16d6cf3c326b224"
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

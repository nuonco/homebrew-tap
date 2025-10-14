class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.668"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.668/nuon_darwin_amd64"
    sha256 "f6d9707e8797850eb063fedfd0d6c5905a09f397e25ffaeab8ee10f46eac0a1e"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.668/nuon_darwin_arm64"
    sha256 "02f6b4515bb44171e11f0cfc5c9cd4db9c6af09c8d6c6509378a73d3775fd74d"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.668/nuon_linux_amd64"
    sha256 "2549d9bc737854695877b654449abe1c2d67f98bcf668aa702cc7fe032e66f37"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.668/nuon_linux_arm"
    sha256 "4cc919508bcf8f001c2ec3220a1f5d33a7aee2a97ae81a4501e5b1914ea23349"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.668/nuon_linux_arm64"
    sha256 "ded82cf1380f49be912378d0fb734b8e815cb3df16310aa812fdb4ed65bcb69e"
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

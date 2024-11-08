class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.293"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.293/nuon_darwin_amd64"
    sha256 "d9d9844810c14a9e8025f9258510392b7412855a03c53d0999049462bab5086f"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.293/nuon_darwin_arm64"
    sha256 "9f1717c6eb79960e1c3cd7fba5a0178b0ebf3cbc920e7db5bc8c8ef701455761"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.293/nuon_linux_amd64"
    sha256 "8e6be8ca0514d3d72cb50ebc03931db67058fbce6dd7885fee5432a92ff9ccb0"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.293/nuon_linux_arm"
    sha256 "ddba237521d4feb0518416aecdab635519e9670d6502e78bae220a99c94bdd10"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.293/nuon_linux_arm64"
    sha256 "c9c88fb861dfb9efabaf43c1cbf3986a3a30270c5c2d8ef7307b7c675e8d0be5"
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

class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.649"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.649/nuon_darwin_amd64"
    sha256 "be29574ee66f9a5efb72abd2aaf925980f5b2de2d6393c543461cb25210a94fd"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.649/nuon_darwin_arm64"
    sha256 "8c227850dbd0aca3d2188f4d947ba1b8aee741d2f5e07c1b465e6b15fa2ab9d6"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.649/nuon_linux_amd64"
    sha256 "a85e5e18d0ae4ed14c8c36f994d004be9c3a81e49a6a4bd54db3b0a2ffa02bdb"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.649/nuon_linux_arm"
    sha256 "470bcd28002ab889d34feafaffb7a67740c78bd39dfb16bc02194b3ce6685f96"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.649/nuon_linux_arm64"
    sha256 "7d1bcdf6613d69154238e32e707d97b6060f8b292d6f0debedd2f31cfe2684c9"
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

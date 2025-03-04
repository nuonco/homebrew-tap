class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.461"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.461/nuon_darwin_amd64"
    sha256 "a2a820ff4bc954646949e014e40d80ec3055b3d18ef3bef453c0d5a26b772808"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.461/nuon_darwin_arm64"
    sha256 "7d917cb1e9651e306f3d13ce34ebe9500290c63e4335ec98e0166f42b7663c6e"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.461/nuon_linux_amd64"
    sha256 "925a05ca99d6d67275cc31091b035525f034a1b2945e4a97334ad19d58e63c34"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.461/nuon_linux_arm"
    sha256 "9f5a620797e06698e90e86ac1c2116ac4eafd55e4a9f7a68e888571c13cb1726"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.461/nuon_linux_arm64"
    sha256 "c1e0ce3ed3bb774ee59b27d42d721f7cbfd0be1551f6d4f1568d133d2aa91586"
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

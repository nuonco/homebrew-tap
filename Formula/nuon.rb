class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.467"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.467/nuon_darwin_amd64"
    sha256 "f9e3394daa91f188781d9f8284378c597bf89be6580065ea79372f7fd059b57b"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.467/nuon_darwin_arm64"
    sha256 "24bda8f67daa249ca2b072cf3396cffff668ceb3b8a9ce19e1073473c86b655e"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.467/nuon_linux_amd64"
    sha256 "04d95ef623d4cd3586f0239a02d1bc1b95129488d85588ad6b404b7fe048ae74"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.467/nuon_linux_arm"
    sha256 "75ea9b827a0bdab8d33ca0844f23a8f91b9e2169c9ec7209cf8fc89d0f5863d4"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.467/nuon_linux_arm64"
    sha256 "73e5c2210cfebbe8abc19a8b5135b4ebcd82036a93f9fbfcc18f30fe5c92acbe"
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

class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.288"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.288/nuon_darwin_amd64"
    sha256 "976f4fd966c90c60fcb14018e1ad31f1a15e7aadd075b574028a96dd2b9b83e5"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.288/nuon_darwin_arm64"
    sha256 "80304527fdfb1c6ca1f7e70c4db5d8bff8a76488e0fe9a679cfc4cc272af8b1e"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.288/nuon_linux_amd64"
    sha256 "e3a674e2feda6c340f78be0cdddcb112ee16975b089d334daed2aa4dc2a531cd"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.288/nuon_linux_arm"
    sha256 "270383ef75e9d8486a59840d77872005d7e7d859d02075fa2cdb432d4709b140"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.288/nuon_linux_arm64"
    sha256 "2b40ae6eb6681482f0fb6732f2d572c897b9ecc4671fa7e3359f99b28b13475d"
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

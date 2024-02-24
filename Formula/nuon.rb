class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.75"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.75/nuon_darwin_amd64"
    sha256 "044d062518a7e1770308a7fe944ff8240d06c606f8bca69fb561182b8cee4c80"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.75/nuon_darwin_arm64"
    sha256 "e66be0d323e0945ca90518b52a397e2c6a76af6f1dcbdd00753570581bd9484c"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.75/nuon_linux_amd64"
    sha256 "d1a52ffa1202f266a8bf0fd2b05ff8cc8eaadd05a5b4b7ce410db35e645fa1ff"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.75/nuon_linux_arm"
    sha256 "4bb5f92062fbe2b04bd2e205d36bcc686acd64ca2ed3a6735f2f2c62111fadd5"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.75/nuon_linux_arm64"
    sha256 "4b310728472eafa5ff344fdb4d0fbc4b6c1b7832e0b3c62c51ca4612e58562e8"
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

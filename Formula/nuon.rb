class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.371"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.371/nuon_darwin_amd64"
    sha256 "98c99c99c0e35759970b6eb2c3f6a9f97b4b8b3e96ad741e3423cffc75a8d47b"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.371/nuon_darwin_arm64"
    sha256 "4a8682a5d92cb3fadbd495d9e344d9c4bab1e600dddc4bef55906cecc2e8cf23"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.371/nuon_linux_amd64"
    sha256 "0d25832cdb00e90932f775810c161428e4048280c6d8795e6978f9b9cb3ed818"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.371/nuon_linux_arm"
    sha256 "d92014f45f9ffbe491175f8bbfb0b49a17689759bc6aeb7f710d3f5c56894b35"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.371/nuon_linux_arm64"
    sha256 "ac8f1563ddb3962fadf1ba6b7d8dbb4dc269786cd67d005e3a30c3fe010c43b0"
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

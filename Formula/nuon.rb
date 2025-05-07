class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.541"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.541/nuon_darwin_amd64"
    sha256 "e326cef139fe0f5c220bf58c11956f8c268384aaac382728c4c3f5eb73c1f1c3"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.541/nuon_darwin_arm64"
    sha256 "1bde7fc80b8cf81eb7f78589b5010b21f54e29eb263fe1bbb6e5d2caced85fa7"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.541/nuon_linux_amd64"
    sha256 "ae24b7ea7d188cf0e71a18db9505397c7d3ba67154ad2e3ae88767ed5662e7b6"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.541/nuon_linux_arm"
    sha256 "0ab1c6d1f6ab998f02f9a1b5fe598091ff390f745512485324b9e35f0956e402"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.541/nuon_linux_arm64"
    sha256 "cf0b6a8348c282707315d557ce577d6d8604b076e30311366a842d09dd0697fa"
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

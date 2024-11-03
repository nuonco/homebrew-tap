class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.270"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.270/nuon_darwin_amd64"
    sha256 "49fffe62b2b61cea50233791922b1e2e8d4cc1031dca688bfcd25c7dbaa31ebd"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.270/nuon_darwin_arm64"
    sha256 "7cd8b3c43d258a643a1ee491ea6ce7e6483db7294d62f80f402b25ce9f4e4cb1"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.270/nuon_linux_amd64"
    sha256 "c6f79cdaee180e99cbb92636dc03f41a6a531f1e24bedbf5ca9aa48c8d1c9ec4"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.270/nuon_linux_arm"
    sha256 "541339ff771063602655cd98f57cfd3cb171c5fa78a7de9dc4161633819bd8c2"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.270/nuon_linux_arm64"
    sha256 "b8e7a6431a516173d8307893a2a226adf826c048f4830c4caa12a7615ef86f11"
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

class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.504"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.504/nuon_darwin_amd64"
    sha256 "4770fe7e44639a794cc7faec2e9fe4bbdc270bce22907d59ff2b0494d5033b4c"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.504/nuon_darwin_arm64"
    sha256 "56dc8ed3c9b5f8aed2f3a7926f4b0f41e8b670c1326cb43ea7ba12f486657e6a"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.504/nuon_linux_amd64"
    sha256 "e3317e5dd0c9bdafcc7ed249285ebcfd9c4f4fe4970845b983f3b03f55d43158"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.504/nuon_linux_arm"
    sha256 "d721b981b9c94572b23f2d48244b42ec7e7a255e3063b35fadc26bd65b4cad07"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.504/nuon_linux_arm64"
    sha256 "dd40b10ac4d6ef04eccd554c40b40fe3861e9d4e17b82c87b305b7466cd27337"
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

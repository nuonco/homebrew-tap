class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.404"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.404/nuon_darwin_amd64"
    sha256 "3271f0ddb6fed4742327603c0e8c0bbfbf847623acad5bbfd6e7d6c4fca07cc4"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.404/nuon_darwin_arm64"
    sha256 "d214246d0d12bcae480f1cd00edd97406349da4104fdabf5966abc3d9e98b146"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.404/nuon_linux_amd64"
    sha256 "2fb6ef08e7f2bf855501eeea88d5b366fcb291e25978ee3e4a8592a6f2c4e525"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.404/nuon_linux_arm"
    sha256 "dfcfe26a24419f4b24444fdf253890e2004bcf3a0e040cd568db2bb390a2e79f"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.404/nuon_linux_arm64"
    sha256 "aeb2fe6950f1fd8702348ef8a82f3a16cc1fe5f252606b628ad36493aa1a8da0"
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

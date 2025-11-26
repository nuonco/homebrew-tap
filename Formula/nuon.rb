class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.708"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.708/nuon_darwin_amd64"
    sha256 "015d03086e7e883ec5a75a9fa9498cc4a7caf4c62b59125952c9e9f538712400"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.708/nuon_darwin_arm64"
    sha256 "6978d66acd322bbbaa5807709b6a145915a58799d5491d4a22a14bfb03d47d77"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.708/nuon_linux_amd64"
    sha256 "1ce74034e8457f42be150f79b0e73b149b48adeefc458561780b0fb0db144317"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.708/nuon_linux_arm"
    sha256 "aa388caeaeedb015b1105f7c3990078a1a7e8425805dfbc608d9e0bafb07747d"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.708/nuon_linux_arm64"
    sha256 "91b3ece76b6a245be09de20121a9f38fad9299926f36643bb3e4f6e71d37dc42"
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

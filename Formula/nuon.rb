class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.327"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.327/nuon_darwin_amd64"
    sha256 "df54d7a61a16ab3f6530d7e572100aead1d9b8bb0f6921f03b70f2bb9fde5e1d"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.327/nuon_darwin_arm64"
    sha256 "d05d74c459d6e49881519787af80aa28da985cb745eadb328ecdba09c7732afe"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.327/nuon_linux_amd64"
    sha256 "7c31d82f5eff90aaeeaa29ec8078dc4006fae1b6a3e7cee7feec484a70b25767"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.327/nuon_linux_arm"
    sha256 "cd86e2b49833ba97ad37ecc457b723b1a79e7c1aed4cad62241381584645a519"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.327/nuon_linux_arm64"
    sha256 "fd17ec3d2586d7a50a8e6faba763733bab9b43ea4b90ff81ec75c6f2a7d05a94"
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

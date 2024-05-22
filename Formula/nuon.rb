class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.143"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.143/nuon_darwin_amd64"
    sha256 "bfea2c8465d9b4f35dea590a81254600c5bece9e9b6bb3e2e765ede73cccb299"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.143/nuon_darwin_arm64"
    sha256 "2fade965f0eb220d5b12ed19aefbfbecb4c37243e889335354dfb64269f86a5d"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.143/nuon_linux_amd64"
    sha256 "6c53aeed6c1e2e3b9b3b9f81cd56e5f03f12d9a347102f6eb3dbc2c71bb2e413"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.143/nuon_linux_arm"
    sha256 "59f90ffdc94245b80d48d570c138f1eb3801e8d596b5369309dd18a1fc7d53c0"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.143/nuon_linux_arm64"
    sha256 "b9ccde2c2463beceb24917dadf18e19a064133a714f0ec17b03ae6ae20a2136e"
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

class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.434"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.434/nuon_darwin_amd64"
    sha256 "8a4b08116fc7188bce4bbbe0995b97ceac2ea93dcd0ac568732eb758f57fd582"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.434/nuon_darwin_arm64"
    sha256 "99722a9c9d3a71bc366985bbf257fad7ae78c203a120cda9fe6db2c3213b4ac0"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.434/nuon_linux_amd64"
    sha256 "3b7bdd617682f7d84b2f5e1787432ddf1c9208e9f1808f3268f31f5d4906e13b"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.434/nuon_linux_arm"
    sha256 "daa8de44017ccc30d4bf9b949421cbcd4f4b43e9f192fb68865e1c79ff637be9"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.434/nuon_linux_arm64"
    sha256 "30323129f4e4af4c6405bbc3adb783ee51bd563d10ebd6544e6430d882d5e16c"
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

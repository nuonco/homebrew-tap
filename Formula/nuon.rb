class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.558"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.558/nuon_darwin_amd64"
    sha256 "80b83919f1772240ad4cafbb95dfe3c95cdedbaeaf089da0de08677dbb487b04"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.558/nuon_darwin_arm64"
    sha256 "4ffe531fb6cca49033b6ca4f0cbd228b1cbde49ae0626abf264b4fcf7a70dc04"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.558/nuon_linux_amd64"
    sha256 "270d6c624718095ec924575ca16614682a53e696613c90a49ef80adc5bfc9ab7"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.558/nuon_linux_arm"
    sha256 "fb5c494bc58566f61c60f8dbcf2fda2644f24bcf1ccdc2ae86b3ea8e36a019c7"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.558/nuon_linux_arm64"
    sha256 "f2010dd95f88c4405d553dfb79877eb54c0cb1a1ec867c500a3384c5d9915c66"
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

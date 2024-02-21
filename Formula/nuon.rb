class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.69"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.69/nuon_darwin_amd64"
    sha256 "ed53b1c39bc2fa0deadaf0987b4af10d18510ee22bde5b65d93ac3b0ce6ff236"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.69/nuon_darwin_arm64"
    sha256 "513a0e0279a9a5ba13542625257c4fde7293f181203a5bfe2b27ee0fb7fd93e5"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.69/nuon_linux_amd64"
    sha256 "9a00064d6e9e8ef00fe021a812b66501a6d6de583ee9c65da3c4ade013f76ebe"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.69/nuon_linux_arm"
    sha256 "f86ecc078cc77c0bef9aa0dd1b6652fa54d61f19ff22b62f40dceef780b4cbd6"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.69/nuon_linux_arm64"
    sha256 "f782fefac80dc3fa6799b4f62a1a8c181b0e927b8381bc449cbf59a7f0f71ac1"
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

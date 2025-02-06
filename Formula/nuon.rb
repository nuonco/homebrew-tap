class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.392"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.392/nuon_darwin_amd64"
    sha256 "cbe2a585cd967c0696eec7948c89c824f847d48570ae2298b8f9af440291b247"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.392/nuon_darwin_arm64"
    sha256 "a109b5e7b6aeaad3f8c9347411bf8c196f1bbf840c01c60d3d6354b9d554b0b4"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.392/nuon_linux_amd64"
    sha256 "af7e640ece996a8057f33cef7312d7f2f43981547b2273578c116c7621eb74c2"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.392/nuon_linux_arm"
    sha256 "70eee8e1bdcb6e62b8b4e1b3acd7db1fa3235d0074623a9650eae1a7c324994a"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.392/nuon_linux_arm64"
    sha256 "da15a220193b3debf2cdaa2d0dd760d9a67a5ad6a115d6c5ef3c0e42bc6ee1ed"
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

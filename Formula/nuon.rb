class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.136"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.136/nuon_darwin_amd64"
    sha256 "729c6e647575028720efbefaab9d572c7b7167bb5a1e1319ca9c0ab6dc0851ec"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.136/nuon_darwin_arm64"
    sha256 "bfd321eb74f7dd258a960a0a3693f3a6520fba3aa7739ec92b973e889a134e92"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.136/nuon_linux_amd64"
    sha256 "cf200fc0c46d0503d9e73201713115f1f3bf1a9aa0ab6f3f110fb5ad6f31dded"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.136/nuon_linux_arm"
    sha256 "bf8a7dd2b8bf4928f3e0f11ae95a6e4b06af834222195f4686ce00f6b324e712"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.136/nuon_linux_arm64"
    sha256 "512cc110c5e9732c1d4374ab2cf68c5485d1110ef2427eeeb8a79cbfe9fe57f3"
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

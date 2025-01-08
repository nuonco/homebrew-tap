class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.357"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.357/nuon_darwin_amd64"
    sha256 "16dbd22c943bd41cdc06f592cb4d0d97048412964c7f7076f76dca4aa4f297e0"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.357/nuon_darwin_arm64"
    sha256 "596d0dba1550643ee0d77711a04a465163ca54399dbf5240d2614a2cafea1ad3"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.357/nuon_linux_amd64"
    sha256 "7bac2f2d11a7dd8a2bbe997a7bde6fef3ee26a39b1d73bc85e33042b9b2e1730"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.357/nuon_linux_arm"
    sha256 "37c5a9b81d6a6cce8ceb3942eaac602a25278514cf26e06b58cdd48d8692788e"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.357/nuon_linux_arm64"
    sha256 "8f1205af27cd5a0f27187a5bca1905197b1f91e2c1fc23fe05efaeb53308ac80"
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

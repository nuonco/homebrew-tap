class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.660"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.660/nuon_darwin_amd64"
    sha256 "1d6ab81ca7cec60cd77ca255b74a2c627e0df1b75bb17a34cbea005287be1bf4"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.660/nuon_darwin_arm64"
    sha256 "9fafb7e2df1f5688e1518604c75c46ec9f4a85ad6c6692e493f2fb1fcaf1b407"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.660/nuon_linux_amd64"
    sha256 "740ad3932efebd1b9a0a12238cd4efe64715f51127a210837840af9dd76f3f2e"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.660/nuon_linux_arm"
    sha256 "3c7ec0043ac65a426defa074c090ed3ab19d652bd78da13f741b10c9f7ca80cb"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.660/nuon_linux_arm64"
    sha256 "704c1a4d1d14e47d05c624ff94ffd2d1f05e693c3ff3d51763641d98b9917cc9"
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

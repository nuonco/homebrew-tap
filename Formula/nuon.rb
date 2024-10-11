class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.235"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.235/nuon_darwin_amd64"
    sha256 "02cae6edaa580267e00ee1763132ab0dc30cb7f1008dbf238fa1f07eaa6e583d"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.235/nuon_darwin_arm64"
    sha256 "fe86058151be11a2129698f89734de9079357a9c6bc9bb974026664ef34129e0"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.235/nuon_linux_amd64"
    sha256 "eee150649dffbe14e11b74888784a7be1213345629760dfff14e1d67dcf1ca8b"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.235/nuon_linux_arm"
    sha256 "d01e193fcefe3d07ef471274816b6696f955c4f224ff34055c13f760216333af"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.235/nuon_linux_arm64"
    sha256 "78824b8a5c3dc25e29199035c60d73a184694a5a4fc168a46bd0febab699c18a"
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

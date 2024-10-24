class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.261"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.261/nuon_darwin_amd64"
    sha256 "9e29b5eb1b9ec0b2102001f0933683fe9013f28c8cc9abdd1f99c837afef9c4c"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.261/nuon_darwin_arm64"
    sha256 "4c115f4bef62106f4ca34dec1bccd1aa9be207f333caa5b542ee0f069253089e"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.261/nuon_linux_amd64"
    sha256 "514a20dd2786f06ebd104c9374e1bbaa9f1d3eb8177bf569154e4bb11b2e6990"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.261/nuon_linux_arm"
    sha256 "dfad7f86a49cbd95f9b4277294eb83efc21902d5c71b867db18673e42b5085b2"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.261/nuon_linux_arm64"
    sha256 "32e5427fabf98a40e098d19502146539f1a04f378df4b9c583e34f5350bc552a"
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

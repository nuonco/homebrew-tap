class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.385"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.385/nuon_darwin_amd64"
    sha256 "4bb7c30b71327f485d818f3e676820287375590bd1dee80b551d5a6f41c68cc8"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.385/nuon_darwin_arm64"
    sha256 "4a9c8068ff950154c7e045e60b3e460bbf6037ad60419e5383e1c293debbfb61"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.385/nuon_linux_amd64"
    sha256 "19fe5b9f9cfea4ceb5a0e8a31edce92c91cdbf1af92efd6e4e5af0de91421558"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.385/nuon_linux_arm"
    sha256 "ea76f054200052d45aed5d9a1c48dc868e0c0b9c386b5730d5b1ded5604492aa"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.385/nuon_linux_arm64"
    sha256 "c385302bbc07e78e2eef5210a439dd4ddf2bc8bd1827cd2266c6a9b0d2b65c79"
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

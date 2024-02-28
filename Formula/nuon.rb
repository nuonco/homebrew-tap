class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.76"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.76/nuon_darwin_amd64"
    sha256 "0cac13eea0d8cb2f905993eb4c23785db1b703819f0e11b5ea07a3df28e02c73"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.76/nuon_darwin_arm64"
    sha256 "b423c31ef1887aa2bdb837bd00c3e0f1217fc6df4f2418a1dce5b294f6623494"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.76/nuon_linux_amd64"
    sha256 "d557f632da0ade2ff7347644a922ecfb623bd3f106b7d3bfc17e612bf2bd9087"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.76/nuon_linux_arm"
    sha256 "a85026e3ddbd32193da54cf0a11ff1bdc7711ef3261ae42d9d87e8cfe92d0f21"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.76/nuon_linux_arm64"
    sha256 "19a302e677453027801e2a2335f235fce43a4dd2fae909bbf8be0e57524c85d6"
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

class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.68"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.68/nuon_darwin_amd64"
    sha256 "ef5d3cbde50c42a13750cb7765ab9765ce6f3b9e142f941e1101040bc90e80e2"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.68/nuon_darwin_arm64"
    sha256 "1fa1f3156c8c70314954905efd56afc71c5c0bbeb1be91c71e3d91ae5089a924"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.68/nuon_linux_amd64"
    sha256 "ab016b0c50c9d02c90ba7a9446ef7f27080c39278914c033ff4cc1e3bf2d7470"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.68/nuon_linux_arm"
    sha256 "518ac2e99cef9461f2a77810c68e72c87cb90f06e466db6f6f45a085512495e6"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.68/nuon_linux_arm64"
    sha256 "5ca46b5526a86f3b0ff6fc7f1e65d710878a0c78091cdf85ac7dd916e837b9b3"
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

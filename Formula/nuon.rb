class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.445"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.445/nuon_darwin_amd64"
    sha256 "b3f1e845808614eeab4cd4f51372d15dcbe6549a2d8bd115735cd5707c0ad90a"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.445/nuon_darwin_arm64"
    sha256 "82faa896fa21eb63190c0e5fc1bdd2bc6494e951d394e0f9c9c7883901fafa34"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.445/nuon_linux_amd64"
    sha256 "9ca18d5031e817630bc99e74def5158012411fc173c1fe9e924388cc2d006c64"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.445/nuon_linux_arm"
    sha256 "c43eb4e35ea2856d9ea40ddde989b9886b8ddf6539c0b99fa43aba1aa9cb6021"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.445/nuon_linux_arm64"
    sha256 "2ed8a0b06bdeb9b2483ba30d391b520099ebaed39a63931dc08046c51dbb8538"
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

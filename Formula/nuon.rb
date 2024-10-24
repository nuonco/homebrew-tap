class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.260"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.260/nuon_darwin_amd64"
    sha256 "5621f8f2f3e223b28a70d651aeeffe24ae9b02df98032f43aaf1d6c50b461ef5"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.260/nuon_darwin_arm64"
    sha256 "b9f5c568e3b1a54ee9cb49e394bd261bba3151e12d58b64d31fc9df6be81f9dd"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.260/nuon_linux_amd64"
    sha256 "136db5acc3d0859e2263e9ada8ce54194d21c4a5206877fb85b49f14bc6662ce"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.260/nuon_linux_arm"
    sha256 "dfe0e64dd8ce2ef56999a6a5d0c6e22227d546c160f4b0e9c62f5915f1fd70b4"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.260/nuon_linux_arm64"
    sha256 "f09ce3366026878db6303a807c47a277c75f2a6e61d1b0efa487b938ecb143fd"
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

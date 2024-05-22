class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.141"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.141/nuon_darwin_amd64"
    sha256 "0dbef906ff9fa4d42fad5d6a85cfb949d8832f5ab1b20f66cb7ba6a233fd0863"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.141/nuon_darwin_arm64"
    sha256 "4b25bb08fdac9d8e020d8923d9c3a43cdc7bc6ef2c7d09e2d85368f5f30df55f"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.141/nuon_linux_amd64"
    sha256 "a3a58beb33a6cc8317a19c11744c54ef5f25f84fb62ef4c7f2ade15860523d65"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.141/nuon_linux_arm"
    sha256 "9012d58afa17d5cec42b26a38b99c3e9332788999d7bd1eb6890c5755d5fd004"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.141/nuon_linux_arm64"
    sha256 "8dd1af25bd5b61713e2f2660f48f4f30bccc2ea8e8b5ec3a65c39b2b0b4603f6"
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

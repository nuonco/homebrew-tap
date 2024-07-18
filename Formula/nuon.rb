class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.191"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.191/nuon_darwin_amd64"
    sha256 "711e44ed3667f5690f1ea3725a494595ef15f93e225092fbfc3175ba2b570c62"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.191/nuon_darwin_arm64"
    sha256 "daa35f669ac4baee64b28951acec6a3a7c715dbd0fe55fa71fa78ee2a956272f"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.191/nuon_linux_amd64"
    sha256 "54288c729c71d63e8fc19ed41cbe179a93adc1e14d61996db6f5e1b0e68143db"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.191/nuon_linux_arm"
    sha256 "8a0aa7fd8c520cb8104ed94fbfedec4222e2d24bda92736dc0f3038c6ae8f083"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.191/nuon_linux_arm64"
    sha256 "0e22e6e74a7fde26fd8b3bcc4eac8cc48bce65f5300314cf6e7dbeb196f84dad"
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

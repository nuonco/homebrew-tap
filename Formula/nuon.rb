class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.570"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.570/nuon_darwin_amd64"
    sha256 "8b0494c3584b28e30f434f9a995e108f96095c239bcd9f3e7a09dc7b14923715"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.570/nuon_darwin_arm64"
    sha256 "e278b1cfcf257fd4645d7878533aa22f9e15c66db5ce88dbaa13f97b0364a19c"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.570/nuon_linux_amd64"
    sha256 "075caed876515b6b67a0e590b85c4346d574c34465b5a1e9f178b8ff4d6ba575"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.570/nuon_linux_arm"
    sha256 "9d276891e8020a2c5a65ba5d847e8c0cdf4e50cfbdcd2dc376ee4ff54402359d"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.570/nuon_linux_arm64"
    sha256 "adfc36052f8296bbdf89aa3824b09ebb0e33d49977a9a9e5e2224fde2b71152d"
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

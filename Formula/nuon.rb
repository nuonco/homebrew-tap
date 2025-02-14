class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.418"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.418/nuon_darwin_amd64"
    sha256 "3f145eac5e9a11c05eae573e213089ac98d824544ba8b81bfdb53b2f0391c9cb"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.418/nuon_darwin_arm64"
    sha256 "bff83764bf696a25de2dbfa87140a130b6e2b1871efadb40af236b3fb1cfbe29"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.418/nuon_linux_amd64"
    sha256 "5c2f685bdfb969119e811e471e590fcf0732a2bf4634f22857953e94319f2b48"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.418/nuon_linux_arm"
    sha256 "b845f3a1eb33dcd4f231003ff7419e6ab0af035fa8f67c596ff7fe6354e3188e"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.418/nuon_linux_arm64"
    sha256 "1d6fe21eddb46b31088fd279ec290a0e8ea55b5a24fede9dce0a2a585a2f0a03"
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

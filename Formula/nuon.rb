class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.108"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.108/nuon_darwin_amd64"
    sha256 "9ba8af13874a0a1a140045ca29d7f193bc789f192122a0903e15c6fc0261e796"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.108/nuon_darwin_arm64"
    sha256 "5ab17417536584c6b945c872e327acfaa7e122a33080ab95ecf9e4d5c6f4ba1d"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.108/nuon_linux_amd64"
    sha256 "bf070d1d4ecce4d143af89674211bfeb27097abf53e21af6e300bf93af5dc8b7"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.108/nuon_linux_arm"
    sha256 "46a1e47e4f4586f74c6172d6ac327e246c73971b85432c5b0af12cb6d1c4af59"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.108/nuon_linux_arm64"
    sha256 "6b88485e330a5805fe8c7c1f4411f9b5c5068d9c6d698b2cadfe7d48b12ad2ff"
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

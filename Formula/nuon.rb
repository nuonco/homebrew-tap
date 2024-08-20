class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.207"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.207/nuon_darwin_amd64"
    sha256 "308433cf69569b85f12d6ebdbc0d3b3249c10a082110b08bbbf1f5b81b9c0395"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.207/nuon_darwin_arm64"
    sha256 "8d7b76a9da97fdf13fed75d22b121eb6b5e4e17ec647c77e6a780b7faa233c30"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.207/nuon_linux_amd64"
    sha256 "0a4106c2288cd7ce43c8ed2e3a7d79a54f6e6814530382bead6a242616b2feae"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.207/nuon_linux_arm"
    sha256 "9e4a22cc9868db0dfc756ed3b58ea870288b94cbfe551de97f01d14def545457"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.207/nuon_linux_arm64"
    sha256 "7f3321cf176d36f6dbb4f1dd8398a9ad9280fc3ed57c6927527d1186038578a7"
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

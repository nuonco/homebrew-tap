class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.167"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.167/nuon_darwin_amd64"
    sha256 "e0c41f81e42085adf462512aed3704f34c8a2f1a84e0d4892775d82458d76ce6"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.167/nuon_darwin_arm64"
    sha256 "e931c01e5b64c952e279fcf012bf7d940ef86afc1d5dad9bebc4ce3c97f06712"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.167/nuon_linux_amd64"
    sha256 "aa5e5f3ecdb5bbe85c0be6ed8d0130035eaa06b59af7cb8800c58e7c843cd40d"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.167/nuon_linux_arm"
    sha256 "594984401890d99c350a4202aca6b598b54f3f6aec17f25c940d9de3c95d4adb"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.167/nuon_linux_arm64"
    sha256 "3c28c1c3c18975a073e138e134bb68b8264815168a34db090ddb32a9dbbcf446"
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

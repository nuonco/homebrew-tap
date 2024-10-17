class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.245"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.245/nuon_darwin_amd64"
    sha256 "6f3b00d6c4b788d03cd51ff1740c9d3c648ae52cf5cd06eab60767a38ffda110"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.245/nuon_darwin_arm64"
    sha256 "f2a354e6db97bf0aff70d08ee43b5d48957d71615bc155fdce8fdb87af767a56"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.245/nuon_linux_amd64"
    sha256 "48e40e52b52e39df979744a8ed12c4a1fb7fd92a87a35af3703d5b008aa9cd32"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.245/nuon_linux_arm"
    sha256 "f5527b4cf19faddc1006fab7f44e5d42521fa9f4d4b0036956d497d8a8a8ce1d"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.245/nuon_linux_arm64"
    sha256 "9958462903f4e67fa69919272dfaa1133c48e42a4cc6af44645d09759de6e53c"
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

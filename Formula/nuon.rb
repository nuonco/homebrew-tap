class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.315"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.315/nuon_darwin_amd64"
    sha256 "0f804f0481c5a6b901ffe0667636194a1986c5555f8eb1fb885d1a804bcb1e21"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.315/nuon_darwin_arm64"
    sha256 "80db78f6b03f8618615aec0fbceb3143f4d7d6d76fc35bf0f835699f4a7dcdbd"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.315/nuon_linux_amd64"
    sha256 "262d7d9fcc4ad0ad76506b0f10c0841ac70f557ca180b4523203bf52473c06da"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.315/nuon_linux_arm"
    sha256 "fd6a24a5fb9608c3cf172c08c3570ecd4475c403be54164ff3c0b53d12bc76f3"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.315/nuon_linux_arm64"
    sha256 "0ef31dcadda44f5eaefb409db9b710115717a5110682fa53d5474bdf8b851cc6"
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

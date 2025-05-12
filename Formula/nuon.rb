class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.552"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.552/nuon_darwin_amd64"
    sha256 "4f078fe6bc4ebebfeef8cc13c3049dd02e71d2360f8b1410e312b18a1ddd0ccb"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.552/nuon_darwin_arm64"
    sha256 "a1acb2b929e12b872497625fdb4f1b21f2ba4e5c91e90db4704c225d4d9bdf47"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.552/nuon_linux_amd64"
    sha256 "7a8cc16c8aa8cc3d312d9f08303ef7b931291e3640a72866532fe9b793db8fe2"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.552/nuon_linux_arm"
    sha256 "cecf0cf80dac4b9b37e06a1ab0e0c510b15185ea0a1bca8d0ff2ce3fa2a7d399"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.552/nuon_linux_arm64"
    sha256 "fdbfe851d72939d883431f464e55cb3cf9e24894b104982bb1f512cf92b91296"
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

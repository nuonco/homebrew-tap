class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.498"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.498/nuon_darwin_amd64"
    sha256 "eab75cd83dd3b20cf7fde891b542ac336c4a50b4fd42b502d03d658ec340e2de"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.498/nuon_darwin_arm64"
    sha256 "05d9fa19f48e216dac1e06f9477e1d9a74a9ac2723755be86e81f8f72628c0d2"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.498/nuon_linux_amd64"
    sha256 "f30ab6e2ace0f9fb27b969c3e4bd81f84ebbfe0a1ee66586990b834025bf9f4e"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.498/nuon_linux_arm"
    sha256 "0e3442d2e63adf5c7aef4604b13e2e034f40f44b9569c1384ccbb63f06bf50d9"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.498/nuon_linux_arm64"
    sha256 "2c74a23ec772defe1e94ba289a48136b51f2a91bb07969b0d8809d07bfa0f9e1"
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

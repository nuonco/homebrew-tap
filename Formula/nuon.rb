class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.147"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.147/nuon_darwin_amd64"
    sha256 "2bb0a1dc1edc5ea168c048bc0903674c8d9c834c761fb936947d215311f4b9db"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.147/nuon_darwin_arm64"
    sha256 "ff14a903a4d415ae89ca3d15fbcb7a24d03a40ecf6585e58cb934696a4987914"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.147/nuon_linux_amd64"
    sha256 "7775a8d5e8c28cdbfe3bcfb02bdf10581541ac8d4bc1f91fdce3e84e47882831"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.147/nuon_linux_arm"
    sha256 "966e5547ad78d9a20f6afe22b61f46159d53356495d82479b71875158a96c882"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.147/nuon_linux_arm64"
    sha256 "acd63f357d0f7b9d3258daceb7d672ddd329551634d27e5f3a1ddaddfe4a1fb0"
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

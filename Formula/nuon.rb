class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.168"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.168/nuon_darwin_amd64"
    sha256 "9c1905dbc2517f555a0fe7b175ba379c9d815d6ea28bffc902363e7e94c02165"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.168/nuon_darwin_arm64"
    sha256 "6b5a5df3fc3a9fc62f7e92942eb5ede05045e5743a44b58a77b6799d59d63296"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.168/nuon_linux_amd64"
    sha256 "06d44594278118ac1d1e7cb3e6d8064d193068cc85a8500296615cfe8cf77efd"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.168/nuon_linux_arm"
    sha256 "71a6592adbfe3aed5dbcfc1695978c0c423cf4ff2cd47bb7957ee7d774ea78a6"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.168/nuon_linux_arm64"
    sha256 "f89b726588a701b8e899d2e07f4b355dc0e45b8e334dd2bd3ca1932c95778ebf"
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

class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.34"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.34/nuon_darwin_amd64"
    sha256 "402cf778c048cf897745e3535a5af91f5103b2d9df728c2ebd6721a0276cf40e"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.34/nuon_darwin_arm64"
    sha256 "83976e513ac1219a2b4f75a9d72819ea1ec267fbe32ca18db4ea7ced04cd74c6"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.34/nuon_linux_amd64"
    sha256 "0a434be6a71a2ee9c399a274c4e1b8ef93060626f3d6fb44f0ce9562287eab29"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.34/nuon_linux_arm"
    sha256 "4532214aff14a091e4e9992572f00da38e7dbf03b9ec89c4e9882fadf3b8e843"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.34/nuon_linux_arm64"
    sha256 "48a84cb09ffe582ae3b6d29b52ce0888fdc8316be161e002c36a45cd992b3b5e"
  end

  def install
    bin.install "nuon"
  end

  test do
    system "#{bin}/nuon", "version"
  end
end

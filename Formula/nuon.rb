class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.477"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.477/nuon_darwin_amd64"
    sha256 "12ac4e6ed56b44a415557e8d8ebcc9f13a65eac86fa3e624594a8fde87e7e013"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.477/nuon_darwin_arm64"
    sha256 "ac619019e1ad0ba3b4853432e39704954ec4f56237e66c27bb8fc6e295bd9d1f"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.477/nuon_linux_amd64"
    sha256 "e51e770c9fe798a60f2c0fa98e50f58a7e1f77684b7889d8fd5d07cfd920dda8"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.477/nuon_linux_arm"
    sha256 "dd57f366f934a8daf2845075817af4514c938a01b0cab1ce2bdd98ac8c30d338"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.477/nuon_linux_arm64"
    sha256 "46063827ada1dc566f94c48e79f50f3fea033777f3aa50efacba67fd98ea9fba"
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

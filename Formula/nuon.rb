class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.363"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.363/nuon_darwin_amd64"
    sha256 "61cfcfe2c71ba2cce66d4e8af542cfe05ee2ed4f28bf907981bafe43b3374f00"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.363/nuon_darwin_arm64"
    sha256 "7e59a13394293f6c3ad68cb67781dfd9b38f8b68aa24237018bb2dfd168df235"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.363/nuon_linux_amd64"
    sha256 "30d19b4ba7048adf51ed6af83c9439cfc0a29b15afd498824aca3c3c5ce55735"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.363/nuon_linux_arm"
    sha256 "a263da40fbe7adcba564750ac44699b18746a70a8cb39897fe25b1b5003c5770"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.363/nuon_linux_arm64"
    sha256 "d346f56e0d9809dd0edf1ce5c4c5a979fd272b51cedd91dd97d022ffd6ecca37"
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

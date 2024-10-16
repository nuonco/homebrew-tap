class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.240"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.240/nuon_darwin_amd64"
    sha256 "03eaa30e280fbe7d09ae42cb036e1ecbcbaaddb25e2e7ac99e1d8bc878884f53"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.240/nuon_darwin_arm64"
    sha256 "59029fa14443df2eee0e3c4015acbe1cd99bb6300a0c4dcd59914e254b7d6d97"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.240/nuon_linux_amd64"
    sha256 "cec7324ae008658d2d9f802bb3ee3d628903d5b6f5e18656198796989463489f"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.240/nuon_linux_arm"
    sha256 "eef2fb23c9fb0de73d80cfcedc9fc89394d56e4abfbcef27253495536e37d56a"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.240/nuon_linux_arm64"
    sha256 "914d8c82a206a3b3fb02a62cf70f7b0bbc7546f9e8c20e88eb35b92f5cfd62ed"
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

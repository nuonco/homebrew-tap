class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.171"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.171/nuon_darwin_amd64"
    sha256 "9c6da3e01d03acf4d124b257b5f4d364256ef542977ed65763f3c8eb5ab3c311"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.171/nuon_darwin_arm64"
    sha256 "215481ef8c0fb6ac52429a5e096231a13aecaaeb30f6cb60bf8abf6f353b7671"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.171/nuon_linux_amd64"
    sha256 "1ada46eba8cd52bb0b14b4e11e2a6830f545cfbc7faf17a7ef1cf3528dfda7d7"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.171/nuon_linux_arm"
    sha256 "02a4140b358ff33fbca4e09141ee0bd944c5ee820489fb7a5b30a48b94fc04cd"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.171/nuon_linux_arm64"
    sha256 "af4372c2826cc5671df9beeec40f3238fab54118f7100f6e0489e0b18c7306ea"
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

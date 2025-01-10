class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.358"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.358/nuon_darwin_amd64"
    sha256 "ae9676ea3ffa3ce581b3c52b08fae09903bfb3c2dbf9b49a21efd26b45b9ebf7"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.358/nuon_darwin_arm64"
    sha256 "8041c6af4ead2938404c13172a6dcdf2dc2390f4faa1e4271a2f4a5396cbeaaa"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.358/nuon_linux_amd64"
    sha256 "e01f7080cca575fc5cb3bc5ea862da56bebaaf8673f7aeb495c39b840b8c5595"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.358/nuon_linux_arm"
    sha256 "38c9ce0a81305d92c603ae33e0f8e1b65f1f9a7fdc1c33989297a8bd800ef5ac"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.358/nuon_linux_arm64"
    sha256 "34718b898faf0f1851cc51c0c66f5abeec59c3a4e8046fde2db80b26493e2deb"
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

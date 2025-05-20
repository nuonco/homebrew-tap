class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.567"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.567/nuon_darwin_amd64"
    sha256 "cd59c14a50fca0039d07e61fa92052bf8bc93d8e3e23d9deeb411ffe0136b664"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.567/nuon_darwin_arm64"
    sha256 "69a41cd7b97460a67b4be4dfe0d327788b0c154cd8be8df67322b4658210b418"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.567/nuon_linux_amd64"
    sha256 "a4e2ec7be1fa62f857df2db19b60275ab8657478a6085bd85cd2141f6d31b6d1"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.567/nuon_linux_arm"
    sha256 "8214c3ffcb04857cf92408dd44639147f30432b8df67e9bf970b98f85d231dbd"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.567/nuon_linux_arm64"
    sha256 "d0dc39c75df78e2f7f3874827acafaf2eec35720fe1b0c40ddd7fbeaad16f1e7"
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

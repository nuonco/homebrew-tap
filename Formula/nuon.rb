class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "0.19.40"

  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.40/nuon_darwin_amd64"
    sha256 "97bac540570073fd5f9f1e72c325889fc31b455ddef688d893fc4429ce41be26 bins/cli/out/nuon_darwin_arm64 11208a5949bb27da30e0fa0891139989dc642d8ec75fa3e4659d45eb7c30dfe9 bins/cli/out/nuon_linux_386 b296e244389151db6479f88e567c5e871438e2c5b330646c75e15ca81c4b8f48 bins/cli/out/nuon_darwin_amd64 8e6a3e8b0b8ab8d545841bfcbcfa86e6d526c30cc0ca8dd7c5d448ab332675a5 bins/cli/out/nuon_linux_arm 6fd879404a0984c1d8e72fd63f693fcec76aa2e8815e6454218cb4743fe54a50 bins/cli/out/nuon_linux_amd64 a463d9b6cff59dab4e8fa61d670ae1d1ba45b75ae3e87d22388dd6c2aca38b85 bins/cli/out/nuon_linux_arm64"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.40/nuon_darwin_arm64"
    sha256 ""
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.40/nuon_linux_amd64"
    sha256 ""
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.40/nuon_linux_arm"
    sha256 "97bac540570073fd5f9f1e72c325889fc31b455ddef688d893fc4429ce41be26 bins/cli/out/nuon_darwin_arm64 11208a5949bb27da30e0fa0891139989dc642d8ec75fa3e4659d45eb7c30dfe9 bins/cli/out/nuon_linux_386 b296e244389151db6479f88e567c5e871438e2c5b330646c75e15ca81c4b8f48 bins/cli/out/nuon_darwin_amd64 8e6a3e8b0b8ab8d545841bfcbcfa86e6d526c30cc0ca8dd7c5d448ab332675a5 bins/cli/out/nuon_linux_arm 6fd879404a0984c1d8e72fd63f693fcec76aa2e8815e6454218cb4743fe54a50 bins/cli/out/nuon_linux_amd64 a463d9b6cff59dab4e8fa61d670ae1d1ba45b75ae3e87d22388dd6c2aca38b85 bins/cli/out/nuon_linux_arm64"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.40/nuon_linux_arm64"
    sha256 "97bac540570073fd5f9f1e72c325889fc31b455ddef688d893fc4429ce41be26 bins/cli/out/nuon_darwin_arm64 11208a5949bb27da30e0fa0891139989dc642d8ec75fa3e4659d45eb7c30dfe9 bins/cli/out/nuon_linux_386 b296e244389151db6479f88e567c5e871438e2c5b330646c75e15ca81c4b8f48 bins/cli/out/nuon_darwin_amd64 8e6a3e8b0b8ab8d545841bfcbcfa86e6d526c30cc0ca8dd7c5d448ab332675a5 bins/cli/out/nuon_linux_arm 6fd879404a0984c1d8e72fd63f693fcec76aa2e8815e6454218cb4743fe54a50 bins/cli/out/nuon_linux_amd64 a463d9b6cff59dab4e8fa61d670ae1d1ba45b75ae3e87d22388dd6c2aca38b85 bins/cli/out/nuon_linux_arm64"
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

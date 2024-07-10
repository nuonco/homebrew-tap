#!/bin/bash
# shellcheck disable=SC2086,SC2046,SC2250,SC2312

version=$1
artifact_url="https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/$version"

checksum_file=$(curl -s "$artifact_url/checksum.txt")
nuon_darwin_amd64_checksum=$(echo "$checksum_file" | grep "/nuon_darwin_amd64$" | cut -b -64)
nuon_darwin_arm64_checksum=$(echo "$checksum_file" | grep "/nuon_darwin_arm64$" | cut -b -64)
nuon_linux_amd64_checksum=$(echo "$checksum_file" | grep "/nuon_linux_amd64$" | cut -b -64)
nuon_linux_arm_checksum=$(echo "$checksum_file" | grep "/nuon_linux_arm$" | cut -b -64)
nuon_linux_arm64_checksum=$(echo "$checksum_file" | grep "/nuon_linux_arm64$" | cut -b -64)

cat >./Formula/nuon.rb <<EOL
class Nuon < Formula
  desc "CLI client for Nuon"
  homepage "https://www.nuon.co/"
  version "${version}"

  if OS.mac? && Hardware::CPU.intel?
    url "${artifact_url}/nuon_darwin_amd64"
    sha256 "${nuon_darwin_amd64_checksum}"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "${artifact_url}/nuon_darwin_arm64"
    sha256 "${nuon_darwin_arm64_checksum}"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "${artifact_url}/nuon_linux_amd64"
    sha256 "${nuon_linux_amd64_checksum}"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "${artifact_url}/nuon_linux_arm"
    sha256 "${nuon_linux_arm_checksum}"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "${artifact_url}/nuon_linux_arm64"
    sha256 "${nuon_linux_arm64_checksum}"
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
EOL

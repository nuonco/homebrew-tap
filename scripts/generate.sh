#!/bin/bash
# shellcheck disable=SC2086,SC2046,SC2250,SC2312

version=$1
cli_artifact_url="https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/$version"
lsp_artifact_url="https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/$version"

# Fetch CLI checksums
cli_checksum_file=$(curl -s "$cli_artifact_url/checksums.txt")
nuon_darwin_amd64_checksum=$(echo "$cli_checksum_file" | grep "nuon_darwin_amd64$" | cut -b -64)
nuon_darwin_arm64_checksum=$(echo "$cli_checksum_file" | grep "nuon_darwin_arm64$" | cut -b -64)
nuon_linux_amd64_checksum=$(echo "$cli_checksum_file" | grep "nuon_linux_amd64$" | cut -b -64)
nuon_linux_arm_checksum=$(echo "$cli_checksum_file" | grep "nuon_linux_arm$" | cut -b -64)
nuon_linux_arm64_checksum=$(echo "$cli_checksum_file" | grep "nuon_linux_arm64$" | cut -b -64)

# Fetch LSP checksums (if available)
lsp_checksum_file=$(curl -s "$lsp_artifact_url/checksums.txt")
if echo "$lsp_checksum_file" | grep -q "nuon-lsp"; then
  has_lsp=true
  lsp_darwin_amd64_checksum=$(echo "$lsp_checksum_file" | grep "nuon-lsp_darwin_amd64$" | cut -b -64)
  lsp_darwin_arm64_checksum=$(echo "$lsp_checksum_file" | grep "nuon-lsp_darwin_arm64$" | cut -b -64)
  lsp_linux_amd64_checksum=$(echo "$lsp_checksum_file" | grep "nuon-lsp_linux_amd64$" | cut -b -64)
  lsp_linux_arm_checksum=$(echo "$lsp_checksum_file" | grep "nuon-lsp_linux_arm$" | cut -b -64)
  lsp_linux_arm64_checksum=$(echo "$lsp_checksum_file" | grep "nuon-lsp_linux_arm64$" | cut -b -64)
  echo "✅ LSP artifacts found for version $version"
else
  has_lsp=false
  echo "⚠️  LSP artifacts not found for version $version, skipping LSP installation"
fi

# Generate formula with conditional LSP support
if [ "$has_lsp" = true ]; then
  desc_text="CLI client for Nuon with Language Server Protocol support"
else
  desc_text="CLI client for Nuon"
fi

cat >./Formula/nuon.rb <<EOL
class Nuon < Formula
  desc "${desc_text}"
  homepage "https://www.nuon.co/"
  version "${version}"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "${cli_artifact_url}/nuon_darwin_amd64"
    sha256 "${nuon_darwin_amd64_checksum}"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "${cli_artifact_url}/nuon_darwin_arm64"
    sha256 "${nuon_darwin_arm64_checksum}"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "${cli_artifact_url}/nuon_linux_amd64"
    sha256 "${nuon_linux_amd64_checksum}"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "${cli_artifact_url}/nuon_linux_arm"
    sha256 "${nuon_linux_arm_checksum}"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "${cli_artifact_url}/nuon_linux_arm64"
    sha256 "${nuon_linux_arm64_checksum}"
  end
EOL

# Add LSP resources if available
if [ "$has_lsp" = true ]; then
  cat >>./Formula/nuon.rb <<EOL

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "${lsp_artifact_url}/nuon-lsp_darwin_amd64"
      sha256 "${lsp_darwin_amd64_checksum}"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "${lsp_artifact_url}/nuon-lsp_darwin_arm64"
      sha256 "${lsp_darwin_arm64_checksum}"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "${lsp_artifact_url}/nuon-lsp_linux_amd64"
      sha256 "${lsp_linux_amd64_checksum}"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "${lsp_artifact_url}/nuon-lsp_linux_arm"
      sha256 "${lsp_linux_arm_checksum}"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "${lsp_artifact_url}/nuon-lsp_linux_arm64"
      sha256 "${lsp_linux_arm64_checksum}"
    end
  end
EOL
fi

# Add install method
cat >>./Formula/nuon.rb <<EOL

  def install
    # Determine CLI binary filename based on platform
    if OS.mac? && Hardware::CPU.intel?
      cli_filename = "nuon_darwin_amd64"
      lsp_filename = "nuon-lsp_darwin_amd64"
    elsif OS.mac? && Hardware::CPU.arm?
      cli_filename = "nuon_darwin_arm64"
      lsp_filename = "nuon-lsp_darwin_arm64"
    elsif OS.linux? && Hardware::CPU.intel?
      cli_filename = "nuon_linux_amd64"
      lsp_filename = "nuon-lsp_linux_amd64"
    elsif OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
      cli_filename = "nuon_linux_arm"
      lsp_filename = "nuon-lsp_linux_arm"
    elsif OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      cli_filename = "nuon_linux_arm64"
      lsp_filename = "nuon-lsp_linux_arm64"
    end

    # Install CLI binary
    bin.install cli_filename => "nuon"
EOL

# Add LSP installation if available
if [ "$has_lsp" = true ]; then
  cat >>./Formula/nuon.rb <<EOL

    # Install LSP binary from resource
    resource("lsp").stage do
      bin.install lsp_filename => "nuon-lsp"
    end
EOL
fi

# Add test method
cat >>./Formula/nuon.rb <<EOL
  end

  test do
    system "#{bin}/nuon", "version"
EOL

if [ "$has_lsp" = true ]; then
  cat >>./Formula/nuon.rb <<EOL
    system "#{bin}/nuon-lsp", "--help"
EOL
fi

cat >>./Formula/nuon.rb <<EOL
  end
end
EOL

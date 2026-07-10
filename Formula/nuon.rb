class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1050"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1050/nuon_darwin_amd64"
    sha256 "fb90280e9a152a9d7c29b17db5f8021dfe921d21a010677fb3e7d5b963a79f56"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1050/nuon_darwin_arm64"
    sha256 "c5e239ec64040912cb7dfa8d397e428eb9840296513b022e8ea92c92dcac3c46"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1050/nuon_linux_amd64"
    sha256 "518f2f99e567f6f5b3f0ab06f0a30f18f7d45f61aa602c5af848121286a2c3ca"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1050/nuon_linux_arm"
    sha256 "72d6a92859a4761fea55ed21cd6cf225b4162ddd492ef972839e661477712e62"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1050/nuon_linux_arm64"
    sha256 "95f27e44d33671513d56969058eecd79f21dadeb2b008a97ea3b19a3b19eb870"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1050/nuon-lsp_darwin_amd64"
      sha256 "aadecd13f50494a2a3f27352d5903925c2f8d3c1b66b8a64876a4f77e8d47d73"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1050/nuon-lsp_darwin_arm64"
      sha256 "65f4eff95e6c7569fdb00fce3ce19fe4f44459f44304708e2378ae808b58e727"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1050/nuon-lsp_linux_amd64"
      sha256 "fdf3bdbb6281713360ed4438240d11d001ab1114d7bff4dca68cbc7b2db64fdd"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1050/nuon-lsp_linux_arm"
      sha256 "63fecefbf5ea39084c535b109708603be619431e52dd6d2a7d6016ea560c5356"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1050/nuon-lsp_linux_arm64"
      sha256 "9bf22214241611da845ce067407a584056cd77d513a9e526d3c184c3f875aff0"
    end
  end

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

    # Install LSP binary from resource
    resource("lsp").stage do
      bin.install lsp_filename => "nuon-lsp"
    end
  end

  test do
    system "#{bin}/nuon", "version"
    system "#{bin}/nuon-lsp", "--help"
  end
end

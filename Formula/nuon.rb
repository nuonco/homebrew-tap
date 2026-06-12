class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1008"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1008/nuon_darwin_amd64"
    sha256 "50671a9fbaf6d79d46a656c4853d825939877fda94e9563d57283132e850390f"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1008/nuon_darwin_arm64"
    sha256 "d78dcb52bd62805bda5c53bac836f282b9aa883f6abdc148a567646ff46703bb"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1008/nuon_linux_amd64"
    sha256 "856f8883c2e8876aaf2de2af2e8c01f10a8c8045e062f8ea99a3da4344cbb127"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1008/nuon_linux_arm"
    sha256 "f40984b60bcfa4a643f318eefeb2ed88d6bc1f7a77f20e62b02e00d216c28c4b"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1008/nuon_linux_arm64"
    sha256 "ccb3a5176143ed4a5e9daf8adffa9e71e950fe2f929294dcb50784f082da6582"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1008/nuon-lsp_darwin_amd64"
      sha256 "3891b6b4a6625b1827c1f685abd44866808c0531b45f9b2f2448872fac21b176"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1008/nuon-lsp_darwin_arm64"
      sha256 "b28bfbea2e3b79341b86a5553596b70b238f9c653ff67b198f02743236a57640"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1008/nuon-lsp_linux_amd64"
      sha256 "0d5d9502d68697c2bc84ce343e8282415c9349b31690f96a18f8c46f15aca35a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1008/nuon-lsp_linux_arm"
      sha256 "113f8bb4618496b3f4298566d184c15cd047f6990ac4fcae856fcc39a3e93e5c"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1008/nuon-lsp_linux_arm64"
      sha256 "e6ee5c66ff95f69a29230eeff09f6b268a18a60defb8418890415a83fda51e53"
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

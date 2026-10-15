class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1247"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1247/nuon_darwin_amd64"
    sha256 "36a976867f7852bd90bec7b767d98f707b3347792862d75b3898b0d81c25af38"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1247/nuon_darwin_arm64"
    sha256 "d39bc1db2515a506af81e3ef0f9ed513ee3d732402cf211e14c17fffe9295985"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1247/nuon_linux_amd64"
    sha256 "f61869d774051e0f341fbb19fbcf233d8dc2d48994ff4358d299b68bf460db46"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1247/nuon_linux_arm"
    sha256 "1ec8c6e6cb094fbc67cdaa897efeda3fb31a223bc8552142e616dc51400ae81a"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1247/nuon_linux_arm64"
    sha256 "ccd59b258da9c4aa95b7b40f23520d1b7d2e81c5a38326244a7940bbce6792dd"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1247/nuon-lsp_darwin_amd64"
      sha256 "b57d3577e7af302d3a0d95eef419d71ad1e659faa4dee13157133a84d4e2c536"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1247/nuon-lsp_darwin_arm64"
      sha256 "da548a5acd8cf547655ed8c446eedb4a7eabd46845e77e9ec5cd84ffd86f030e"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1247/nuon-lsp_linux_amd64"
      sha256 "cbcfe2b05f2a3c765441fe8ec366225f5c94cbd0bf5714db0f2688f3d495eb90"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1247/nuon-lsp_linux_arm"
      sha256 "29d7e9e57e17119cb39e2897fbc55614d6c3d63c42be3ac0103e7b07626967b6"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1247/nuon-lsp_linux_arm64"
      sha256 "2d0bf28f4fba48468d01e1b540590eace3a364ae726a02f4b5271f321cc413cd"
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

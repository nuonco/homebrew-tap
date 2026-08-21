class NuonAT0191142 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1142"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1142/nuon_darwin_amd64"
    sha256 "f49eedb7f92fc7befea1db28bda957171f81476ec16b09269a6e5b93a98d73fa"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1142/nuon_darwin_arm64"
    sha256 "dfdf35c0acd903eee8509f2ffeeec2142aa69f67423be043e056dcbab2ffbf33"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1142/nuon_linux_amd64"
    sha256 "8ded1b93db96554cc753fd4cbb930628b1232e922bfd2407a96e45313a346e45"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1142/nuon_linux_arm"
    sha256 "ebf82d8cd3ce3951a1496ea60d3bb9c9f46a3c5ef7292be8eaa2e8776fc79cb6"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1142/nuon_linux_arm64"
    sha256 "a48b5f4711dcd9d1861aeaaaf84497ff2dd960608e05f2329c632b886702965f"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1142/nuon-lsp_darwin_amd64"
      sha256 "22698712a02be9cc16c09e3bc62a9d51c330fcfbc30828033d6c2670e59d9b32"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1142/nuon-lsp_darwin_arm64"
      sha256 "eb255ba048f33396b0d04ca0c4901fe9ab4712f04819e7d9a0fdc4bd34e1a61f"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1142/nuon-lsp_linux_amd64"
      sha256 "21e37798482212b97ecc7f5d87f8c091bcbc5bc0b0cad3ca4870caa1cd1cce21"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1142/nuon-lsp_linux_arm"
      sha256 "98290b741d3babd457c22b230c94861990555ffad35c67b7d44c5ce11c46af29"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1142/nuon-lsp_linux_arm64"
      sha256 "d818b7509ed6bc2f16069cbc45c140922375da7fe003cee6afacb0e9df98de7f"
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

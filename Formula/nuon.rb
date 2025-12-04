class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.713"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.713/nuon_darwin_amd64"
    sha256 "3ae0d8d560a84cede9de1defd8c89f43a496f561f54a5ae70f9012d5e72931c6"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.713/nuon_darwin_arm64"
    sha256 "d2dc746a15d5b2f5b22c60c4652c6876ba6ff2fbc1c26fd3af0b4f8914ed3531"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.713/nuon_linux_amd64"
    sha256 "105236aecb93840788f54ea24a29c2db978177a847913fa933755e854fa3c0c3"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.713/nuon_linux_arm"
    sha256 "a0881434f270bd442ee733418ed01923ec37da81a1612333faaf5da62a601312"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.713/nuon_linux_arm64"
    sha256 "d3de2f02033ce41b9cf284ee1042154dea7ded4051cd9a85cbcd8db435699e20"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.713/nuon-lsp_darwin_amd64"
      sha256 "f0bcb1557c8c06b480ea512bf0e24dc7d5a7bcfae695ef53fe4dad5d0ec9eb8e"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.713/nuon-lsp_darwin_arm64"
      sha256 "77eb58c5fa194157969ef1f6cebf189044652837ef5812e948142d2141dd260b"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.713/nuon-lsp_linux_amd64"
      sha256 "d4d468731ebc4f3c01bb5260484d3699fd5ac3ea8b771d3644f8a11e48920801"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.713/nuon-lsp_linux_arm"
      sha256 "bffd53fac0722e6c02ee65ac632ce1da4ca7f98b6979f8eca0545b5d6b1ff1e8"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.713/nuon-lsp_linux_arm64"
      sha256 "8534bfd69a421a43e590f8f07cb3cb8e44ce073eacde495554f87863d215615b"
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

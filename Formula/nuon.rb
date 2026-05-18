class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.948"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.948/nuon_darwin_amd64"
    sha256 "8571d56c1c178259c9147f3c3160a950193607adb1ad6f6b73417c9aa282ee4e"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.948/nuon_darwin_arm64"
    sha256 "a261a449c7b484b2fe3971a74e75d37d7bf1add45b765d69d7ce18ba12022018"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.948/nuon_linux_amd64"
    sha256 "357398cf9c40ce19bd9990d59f6cba25a346be942509813ae0d0ce0d46e5c01f"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.948/nuon_linux_arm"
    sha256 "0fe12ea006136faf4bb3adb75f747cb1b99e6864053b43f3121a10329fac5cdc"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.948/nuon_linux_arm64"
    sha256 "ddf9a59db7a34214fb2b47e762f64ed929698f8be23192b9de53b484ff2d78e4"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.948/nuon-lsp_darwin_amd64"
      sha256 "9d0ec8a6f674ff1c25ae009eb44a06db3bb5b52da585f71cdb0170d6988a1297"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.948/nuon-lsp_darwin_arm64"
      sha256 "40da8ee1fedb946640ee72aba2b2edf04796856879a205a1a6f6340270132002"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.948/nuon-lsp_linux_amd64"
      sha256 "5b448f6d890c0829f89c778be872740ca6eb96f5abcd63a121bf5688f3e2047c"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.948/nuon-lsp_linux_arm"
      sha256 "600eaebe05c3d6f127bb8fc60129407550dc589439eb496eb074e9cb8935f9bc"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.948/nuon-lsp_linux_arm64"
      sha256 "ebc028df861f9f86c4fb9d6bf7d605f028b8220f8ce4456f93e871e096af54b0"
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

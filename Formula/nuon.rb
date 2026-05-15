class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.946"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.946/nuon_darwin_amd64"
    sha256 "875bd2f0d71f0146d1bd69d1906a69df36803b969f95195ae82a108e4c846baa"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.946/nuon_darwin_arm64"
    sha256 "c1804d3683e8ec06e0c07d8b8a87965f79d28d8ddb4f496f4d2f2025d28d474a"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.946/nuon_linux_amd64"
    sha256 "e650fdb7c1e197a2309094bc3e66446bed3a99afb37835170bcdf5eb29b0d16f"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.946/nuon_linux_arm"
    sha256 "ad23c8ed1fb0ea2e6c188eb81e0c2466fdb096d6cccd6cb860abb40dd5aa2620"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.946/nuon_linux_arm64"
    sha256 "7443f0feab415ad60a6f9289a543b13059a1714a3d82d7d40e748ffdfc3dd13f"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.946/nuon-lsp_darwin_amd64"
      sha256 "9d0ec8a6f674ff1c25ae009eb44a06db3bb5b52da585f71cdb0170d6988a1297"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.946/nuon-lsp_darwin_arm64"
      sha256 "40da8ee1fedb946640ee72aba2b2edf04796856879a205a1a6f6340270132002"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.946/nuon-lsp_linux_amd64"
      sha256 "5b448f6d890c0829f89c778be872740ca6eb96f5abcd63a121bf5688f3e2047c"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.946/nuon-lsp_linux_arm"
      sha256 "600eaebe05c3d6f127bb8fc60129407550dc589439eb496eb074e9cb8935f9bc"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.946/nuon-lsp_linux_arm64"
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

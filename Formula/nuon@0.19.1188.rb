class NuonAT0191188 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1188"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1188/nuon_darwin_amd64"
    sha256 "de1426f0c32c4ffe68e1cc802438adfc7fbc65cd799c2de070c0249a52d18ebb"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1188/nuon_darwin_arm64"
    sha256 "8a7824e84532bbb5baf6455677406825acc78c0eaa6de50196292aeae786b9f0"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1188/nuon_linux_amd64"
    sha256 "48eac54e24028e2936b16b3e5ac9c77b78fa1fcce28cbdfd467080e18017d2e5"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1188/nuon_linux_arm"
    sha256 "fcee6526fbaab73bbfd6b56c42ed7b5efc997ac4a42a688a6765680945497710"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1188/nuon_linux_arm64"
    sha256 "65f991b4f784c01d065fcb51ab3582251a1e72513f7b2d8477720d58dc724625"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1188/nuon-lsp_darwin_amd64"
      sha256 "52584b4a09cd9e39210cf2ba2bfe9745806157958af5c780c56831ce4ad33358"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1188/nuon-lsp_darwin_arm64"
      sha256 "56fa33b6b580d4d33089105b87db1124e7017bb0d3e4f86ea0d4a3146402fca2"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1188/nuon-lsp_linux_amd64"
      sha256 "ba0ebbe041b882e3504e5b5fbe1c84bde50bbc57571f81657fb17a971c468ab3"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1188/nuon-lsp_linux_arm"
      sha256 "7fd60732943c6972e7b6f8b426a1eb4d9430e66b20dc439e1553b310be48f9de"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1188/nuon-lsp_linux_arm64"
      sha256 "56ac44e1d5f862fff71604885c87e39cc254f05207237c7025175768fcdca35d"
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

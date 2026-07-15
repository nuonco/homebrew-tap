class NuonAT0191063 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1063"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1063/nuon_darwin_amd64"
    sha256 "5c95e75ba273173ba55008ec6732ebd76151b753a49e043e4638157bb7295706"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1063/nuon_darwin_arm64"
    sha256 "84231aca97e06dfeb6f38c9bab56effdc6c55ff1774a7829b255639f4d958df7"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1063/nuon_linux_amd64"
    sha256 "92114420fd726ba038194626bf40711686b0b014ecbc8a728dc24329342f57c1"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1063/nuon_linux_arm"
    sha256 "5c91cb32b01f0622ed0416e426b9c8c806617f6a9f9452d1f95e223d7c096c05"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1063/nuon_linux_arm64"
    sha256 "42fb8d2fc1dde4c3521eb9c811f75aa8e1fd5ef8570f224a95fe699cff8ee38a"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1063/nuon-lsp_darwin_amd64"
      sha256 "a5f70f823e3679909fd85d4715bbe61faedd532ffbeb1bf531a02e7d1a29f1ae"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1063/nuon-lsp_darwin_arm64"
      sha256 "ef1bedd39c6f535449eccbf590aef92cc71d81afc3ef4b52018b5ff6989bf97f"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1063/nuon-lsp_linux_amd64"
      sha256 "9c38ab4a8644b602eb8d0cd1c2647a950b567208ad2114cba728e304395b567a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1063/nuon-lsp_linux_arm"
      sha256 "2b5c9c3ed5b40fe0f9d4951bda16b58ca7ba6ace523ab8cd3b39d178815d141a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1063/nuon-lsp_linux_arm64"
      sha256 "16711d82a49e1c0c49be96c19be68c91d57a0920c26c916b32704c3e71c16a7d"
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

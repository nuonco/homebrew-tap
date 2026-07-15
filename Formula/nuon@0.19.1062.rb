class NuonAT0191062 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1062"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1062/nuon_darwin_amd64"
    sha256 "eff20f90e0ab2b491742ce56ce8da9f4b0f7ee5f0b7adcb8622e4036517b33f9"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1062/nuon_darwin_arm64"
    sha256 "c94c3f60e56e9a3cdbfec6874cd9c501ec49dbf67c754b64042f4203ecb227e2"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1062/nuon_linux_amd64"
    sha256 "7fd73def965822adf0c7792df60e4dc97c2c2be598e1df0cbbd7fb7d8932c281"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1062/nuon_linux_arm"
    sha256 "c7db0e833650b2f21b322e5be8626ca8226f6520e5bdd4c467d1bac12aaea806"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1062/nuon_linux_arm64"
    sha256 "afd1ce93144b3574269c3227391c7e159c51420f6f3d4cea37c366bade115b7c"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1062/nuon-lsp_darwin_amd64"
      sha256 "a5f70f823e3679909fd85d4715bbe61faedd532ffbeb1bf531a02e7d1a29f1ae"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1062/nuon-lsp_darwin_arm64"
      sha256 "ef1bedd39c6f535449eccbf590aef92cc71d81afc3ef4b52018b5ff6989bf97f"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1062/nuon-lsp_linux_amd64"
      sha256 "9c38ab4a8644b602eb8d0cd1c2647a950b567208ad2114cba728e304395b567a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1062/nuon-lsp_linux_arm"
      sha256 "2b5c9c3ed5b40fe0f9d4951bda16b58ca7ba6ace523ab8cd3b39d178815d141a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1062/nuon-lsp_linux_arm64"
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

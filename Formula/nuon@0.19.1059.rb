class NuonAT0191059 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1059"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1059/nuon_darwin_amd64"
    sha256 "562460c2c732d8274b5be5154ef3f2991bd9180e14721d00e622582192f7a31a"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1059/nuon_darwin_arm64"
    sha256 "35f1b884144808d25028dffa65394d7df83186c896354a726ed70c7bea67bc5e"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1059/nuon_linux_amd64"
    sha256 "3b2d1f62a6443373cef8ec044f25685b94d4a7d8d5998c5edcc39d82cc2d1c24"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1059/nuon_linux_arm"
    sha256 "6ebe5a7625338edb84444600f74880622b616a4524a7049fc615e036cea1b1be"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1059/nuon_linux_arm64"
    sha256 "04b8d53c91bd9e0cf85d918bb5e7da0497c12d466e03d6ce516d93d752577bfe"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1059/nuon-lsp_darwin_amd64"
      sha256 "a5f70f823e3679909fd85d4715bbe61faedd532ffbeb1bf531a02e7d1a29f1ae"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1059/nuon-lsp_darwin_arm64"
      sha256 "ef1bedd39c6f535449eccbf590aef92cc71d81afc3ef4b52018b5ff6989bf97f"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1059/nuon-lsp_linux_amd64"
      sha256 "9c38ab4a8644b602eb8d0cd1c2647a950b567208ad2114cba728e304395b567a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1059/nuon-lsp_linux_arm"
      sha256 "2b5c9c3ed5b40fe0f9d4951bda16b58ca7ba6ace523ab8cd3b39d178815d141a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1059/nuon-lsp_linux_arm64"
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

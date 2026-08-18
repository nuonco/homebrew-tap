class NuonAT0191127 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1127"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1127/nuon_darwin_amd64"
    sha256 "3aed0a562d545d9532fcec657d2bd6fdfc3aabf9e3e733e631e01a194e613598"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1127/nuon_darwin_arm64"
    sha256 "6a2b866b0addcdcfa7369271c90cc464756bc63b6c931c3929934402b2ce3146"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1127/nuon_linux_amd64"
    sha256 "0981867bbd24a773a197924190363cd3acf9ab167029a53f14bbe9849a9d79ef"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1127/nuon_linux_arm"
    sha256 "472d9c9f0cfee5cf914a0151b0ac8c0376e992fffdd379201f7e7e10a6d450dc"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1127/nuon_linux_arm64"
    sha256 "7688b24290ab4ab740a01f45199f679a10c9cb295f0be6ee3fa8502bb0431341"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1127/nuon-lsp_darwin_amd64"
      sha256 "e8957adb1c4b347be2ca86f119d5fbb4ffe1eb74588cbbfc505b129daf1ecb6e"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1127/nuon-lsp_darwin_arm64"
      sha256 "6e1827a019b7ed53b05b056ac9da2ab2cbf838f6240427a4f420aa7b9737667a"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1127/nuon-lsp_linux_amd64"
      sha256 "ca49f00be0a516d9220265ea7be2cf60fa4daceacd114a9037e8798409411fbe"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1127/nuon-lsp_linux_arm"
      sha256 "edf592078f3b3e427f6c33512ab1e23c90ea8d04b7b9842dd0ad932b145ef5af"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1127/nuon-lsp_linux_arm64"
      sha256 "80aacae376fff8438c2aed2da0174e7b53b3e5e402c17a6fe3d01f1df3d32db8"
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

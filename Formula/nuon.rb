class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.720"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.720/nuon_darwin_amd64"
    sha256 "4a594a4448029adf63661878946aa80053cc43b94d797a0a45227d11fd3e50dc"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.720/nuon_darwin_arm64"
    sha256 "845277d706444154e3791dc759e84084d381bd65f01475ca7dee07ffdb8ce634"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.720/nuon_linux_amd64"
    sha256 "23fa51bab4f7dbdc9d57a5765d5f1a50a8848c70dec90f65c2ed3950f87ba116"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.720/nuon_linux_arm"
    sha256 "e190b2474aee89962a0e4b1a43a49a660bfd7b5caa2a1f1169476d0ae9ab0a2b"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.720/nuon_linux_arm64"
    sha256 "8209331d84aa8d924c935fe408224e72ffd196e7f2978a4b24eb13b7da911cb5"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.720/nuon-lsp_darwin_amd64"
      sha256 "5a783507f9d56aec35d54a2ba3cbe28be570c7cdfa4ec315ee48e89923a25d79"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.720/nuon-lsp_darwin_arm64"
      sha256 "776a9063db74326e9114b2f6c24a69ae2e528183716395a5412ff5bd2c959f3e"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.720/nuon-lsp_linux_amd64"
      sha256 "3ca179c2bbcd56ef4aadf28cd560933e6520a148433ee08eeb20e217eda36581"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.720/nuon-lsp_linux_arm"
      sha256 "3081e816fd2e9eac7e42af1fe2f77a6f8213108daf0edabb38e3b3ca9c7ab204"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.720/nuon-lsp_linux_arm64"
      sha256 "87330080924c8f7ecec0fdce832801b967ff8ac3de0fc82d9aad901f9c071e7f"
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

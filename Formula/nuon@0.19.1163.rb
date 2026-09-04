class NuonAT0191163 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1163"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1163/nuon_darwin_amd64"
    sha256 "12940425bc79070c9c623f2fafe6c73d2a9fc31b3ef9467fa21826b14af6fe09"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1163/nuon_darwin_arm64"
    sha256 "f21ea79494c79f8b7302a2192af6144a2828871262e2c3725fbf40c4e6aeedef"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1163/nuon_linux_amd64"
    sha256 "5eb2eeb32f999baae26912ffd32d5c988521467788c28a4b453248aad24c6892"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1163/nuon_linux_arm"
    sha256 "79316a67d44037a2a141f436ea35154451dd91951e419065fd7fd85581e50a90"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1163/nuon_linux_arm64"
    sha256 "ac1e75de86eb8265dbf298871a78cb71d92051993c4a0c2a4095e6203e3aefcf"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1163/nuon-lsp_darwin_amd64"
      sha256 "a56adcacba6923897fe8de9d8eecc14c845b268697a7bca214382ccc56438644"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1163/nuon-lsp_darwin_arm64"
      sha256 "52dfd26fa542f3c564ada3fd5c6467453f586952bd2823cb4d8a1b49d5b0bcab"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1163/nuon-lsp_linux_amd64"
      sha256 "bb22b3d509866b912e228c581b9b43b94e82c22260f9f317ea7805af588cca79"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1163/nuon-lsp_linux_arm"
      sha256 "3701781120e9f726ebcb4f51ba2d9d415b127dfdad1d052de6e882d970cff7a5"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1163/nuon-lsp_linux_arm64"
      sha256 "ae4e7b80e20e59af43bfd5c48b6b99393f923f7258ea9258e500ed031c1bee49"
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

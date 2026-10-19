class NuonAT0191250 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1250"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1250/nuon_darwin_amd64"
    sha256 "b406968a9c372706032de132be3427be86ce3260de3d7b0168e2d78014ee52ab"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1250/nuon_darwin_arm64"
    sha256 "5ac01da9b7502ea8be2177b43d27e29f1041f9b20a07a362660f82c32f440c7a"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1250/nuon_linux_amd64"
    sha256 "a9a68c3aa8a3b6b02b6136356f3388d8c131e733f20a2d97273d01190ed8518f"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1250/nuon_linux_arm"
    sha256 "583d4e81cd25279616ac33e20e28539dcd18e4d30565ba305ccb552760f7c241"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1250/nuon_linux_arm64"
    sha256 "f4ccea4a3542f2a3d8e110b994f1c158f2d1329448dbfcacd2ca6c9e900a0a53"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1250/nuon-lsp_darwin_amd64"
      sha256 "ee56e275426d07e6bc16e836ee18f071336f2863f58fda6c054c40632f3daedb"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1250/nuon-lsp_darwin_arm64"
      sha256 "255fef44f83102da130ae7b4958c4a11e6021cf43de3c8eb5645ce0bc52768c2"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1250/nuon-lsp_linux_amd64"
      sha256 "aa03eecad43ec589fa0ce5bc3f1e3e5f3650fd8fcb360313632bd1e4c6ddc121"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1250/nuon-lsp_linux_arm"
      sha256 "28b39afff8c84dc548cbc66d4450fe9cd62d42798173f7dcd34460f149dfcd90"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1250/nuon-lsp_linux_arm64"
      sha256 "6398085b22aeb57db17bae961cba1ce6423fbc58640c83cb9a7a68f5283cc0be"
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

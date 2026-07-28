class NuonAT0191081 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1081"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1081/nuon_darwin_amd64"
    sha256 "96370d4c7ab9fa38574f47d876191f8ab454748bb6d5b34a8764dfb5fa521687"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1081/nuon_darwin_arm64"
    sha256 "63e9bceb48bd3f853d293641cc9a24940dfa6a0b734e4f6c342d71f39e750013"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1081/nuon_linux_amd64"
    sha256 "19e7ab9a3ef1cf84610d1b3e819ac2145177e1d62ef7e51c2f8c8708e647470d"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1081/nuon_linux_arm"
    sha256 "775c6a7fa2325ec60c9e1d20bb10275d04d31716c5de0f89b954ff56941a00bc"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1081/nuon_linux_arm64"
    sha256 "b5278a479f51e2a733f1dc5e04ba9054dbdd1d878c774ea6c3b97534a98b24d9"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1081/nuon-lsp_darwin_amd64"
      sha256 "eb6f293f0b5742b0ef5a16295b0bf452b238626284a87b20885fa336cd53d106"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1081/nuon-lsp_darwin_arm64"
      sha256 "b91a43a02e4579fd71dc025f1757dc2a9a23fd07054fd0097f1eaa087b27c3e6"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1081/nuon-lsp_linux_amd64"
      sha256 "76adb2d082c6eac46733bd9b8aacb21fdb3a3a71e33f52ba0d8d515d6df4fd09"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1081/nuon-lsp_linux_arm"
      sha256 "26cbd55cdc1d925f034e3eeb5c839a84c354e5536672018f22285e9b6979f65e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1081/nuon-lsp_linux_arm64"
      sha256 "4f077103ec674535186f5f016b88fc5ca0e7b7ce3afc11ba27d47a33b27ba662"
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

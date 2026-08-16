class NuonAT0191126 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1126"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1126/nuon_darwin_amd64"
    sha256 "fa4b6385539c565d82f9827f3ff6ff2d8c97abe0296b2ba56ce66c38e80a631a"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1126/nuon_darwin_arm64"
    sha256 "7c493cf6155762b9236235fa488a54b210a413a0eeef54359c8a0e27c1c22bf5"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1126/nuon_linux_amd64"
    sha256 "2c1af348ff831c1d38220a7d31692b0bdbd5dfbec3c585294e2a3ec057ea3aba"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1126/nuon_linux_arm"
    sha256 "3194a14a378c1dfbd076701a7197f77874543676f2b7129ba030e1c39c188889"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1126/nuon_linux_arm64"
    sha256 "aa698277d56a7f1506aae727162290bf0f23ddf17d4be870817749d492ad8104"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1126/nuon-lsp_darwin_amd64"
      sha256 "dd0224be13546ead64df85bdc1c386137e40a4acdcdc27bfd70e972e95cd3750"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1126/nuon-lsp_darwin_arm64"
      sha256 "17f7ce1a8f831d11d9c1dddc30a3956271fff7178c670693cb937d956f241599"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1126/nuon-lsp_linux_amd64"
      sha256 "fbe95e4bb70ea81e8e0cc46e99441f22fc4460f1848debf9706505a9f77889af"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1126/nuon-lsp_linux_arm"
      sha256 "c94076cc8946e9230a3d3cd4a3a5bd7fd3cc83d50333111be85c60ae1bca549f"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1126/nuon-lsp_linux_arm64"
      sha256 "4669a4ce6c6d498ac9dfdd5dede39a7080935b7ba6618197ec011a0669cb2f59"
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

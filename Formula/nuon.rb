class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.945"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.945/nuon_darwin_amd64"
    sha256 "445085a844fda30db7b78843374818544ed851cb2f15c63c5695171c18b91d75"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.945/nuon_darwin_arm64"
    sha256 "e5295c7cae18f8a181c6e8a1fe937e028b4cd63a8c9d7c5121512668509bcc43"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.945/nuon_linux_amd64"
    sha256 "c154b2431a5a80a98038cf98f8e84a379082ca34b8c15e66301bb3f7e605417b"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.945/nuon_linux_arm"
    sha256 "809d1a771f5ff909e6144f97d5d5c3d623497ba5e8467a4582191dd0c2402317"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.945/nuon_linux_arm64"
    sha256 "00a68d6e5184a4aced31f237b69ab0f862b60bd582a2a892b1b1dacdaa3271d0"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.945/nuon-lsp_darwin_amd64"
      sha256 "9d0ec8a6f674ff1c25ae009eb44a06db3bb5b52da585f71cdb0170d6988a1297"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.945/nuon-lsp_darwin_arm64"
      sha256 "40da8ee1fedb946640ee72aba2b2edf04796856879a205a1a6f6340270132002"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.945/nuon-lsp_linux_amd64"
      sha256 "5b448f6d890c0829f89c778be872740ca6eb96f5abcd63a121bf5688f3e2047c"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.945/nuon-lsp_linux_arm"
      sha256 "600eaebe05c3d6f127bb8fc60129407550dc589439eb496eb074e9cb8935f9bc"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.945/nuon-lsp_linux_arm64"
      sha256 "ebc028df861f9f86c4fb9d6bf7d605f028b8220f8ce4456f93e871e096af54b0"
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

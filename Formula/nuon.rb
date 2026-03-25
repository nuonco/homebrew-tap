class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.850"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.850/nuon_darwin_amd64"
    sha256 "b5bc516a8e782b2e21f5d8af69c224874490abbaa6de47bb4cc82f47c18c3eaa"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.850/nuon_darwin_arm64"
    sha256 "15750588a0cfbaaf605c42f737a86ec025f5c1310c0d433f9e5de3f8ffbbfc88"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.850/nuon_linux_amd64"
    sha256 "efad5cfcafdfdb5c0ac1924c7e28b7f0d46691f0d05d6a8bda10d9673d720161"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.850/nuon_linux_arm"
    sha256 "a9a23e4fd04ffdef3e68aebbce69456dc5837064d70d44c16482a5adfdd97a86"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.850/nuon_linux_arm64"
    sha256 "331baee7a390e2fbcbd81555f96d31182cbbf24497a6e8a2f6b8f3692f331153"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.850/nuon-lsp_darwin_amd64"
      sha256 "6389b2699beb8a395fc874dcd122e8573f75382fbf7c78a02ddbe73001430784"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.850/nuon-lsp_darwin_arm64"
      sha256 "241fdc6de5da74c6f987e0fb13168481cc6d1c4ac4d3f0ac9f9b278e0e7bb7e0"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.850/nuon-lsp_linux_amd64"
      sha256 "112c2138193f5f10b10e8e17d253824e02822d5c842884ed9d7432bbe700a3bf"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.850/nuon-lsp_linux_arm"
      sha256 "e377e76e1e855929cbb8b4d9335a863e18782be78cbed9324221571a9ef681ba"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.850/nuon-lsp_linux_arm64"
      sha256 "0df5d377d16f4b6343f9cd6bbaba731d0c6713fc7ca0fead38e1bb6e195040e9"
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

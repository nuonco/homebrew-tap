class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.852"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.852/nuon_darwin_amd64"
    sha256 "9fb12fa232386473cca7f532f6831af0a03f8f077a815e4c920a8ee0669311d7"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.852/nuon_darwin_arm64"
    sha256 "63265d2cf02d56bf95c13e59ac269a7233956722a40a14d77da89a6c8ca517fb"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.852/nuon_linux_amd64"
    sha256 "a0c6fd0e01077a00caa915667e47bf3d23969ebda7fa1839b6ba191ec103ec1a"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.852/nuon_linux_arm"
    sha256 "8239438f92490512ec163780b8b620074b82b316c3a99ff5d4453eb8a777dc21"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.852/nuon_linux_arm64"
    sha256 "d3118ad9f9f24489156091689c829a5d9786d79f2e186a0450d6f66f56916035"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.852/nuon-lsp_darwin_amd64"
      sha256 "6389b2699beb8a395fc874dcd122e8573f75382fbf7c78a02ddbe73001430784"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.852/nuon-lsp_darwin_arm64"
      sha256 "241fdc6de5da74c6f987e0fb13168481cc6d1c4ac4d3f0ac9f9b278e0e7bb7e0"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.852/nuon-lsp_linux_amd64"
      sha256 "112c2138193f5f10b10e8e17d253824e02822d5c842884ed9d7432bbe700a3bf"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.852/nuon-lsp_linux_arm"
      sha256 "e377e76e1e855929cbb8b4d9335a863e18782be78cbed9324221571a9ef681ba"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.852/nuon-lsp_linux_arm64"
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

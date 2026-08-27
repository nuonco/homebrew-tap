class NuonAT0191138 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1138"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1138/nuon_darwin_amd64"
    sha256 "bc349ceba10e9ed621682cf0de0ef0f9f9443543d37fbd02621e394295846e07"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1138/nuon_darwin_arm64"
    sha256 "4f62533c741f5c50361fd7ca88a255686edc059375b7d9d181f92cfabb172e63"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1138/nuon_linux_amd64"
    sha256 "2f50aea63f378763ee5690c59490f3fb917d728656102f1547aa01804c25982a"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1138/nuon_linux_arm"
    sha256 "c5cfde0064893520d76cbf5d1a7d0b32faf252b566a9ebed219c7fdcfc68d302"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1138/nuon_linux_arm64"
    sha256 "c7095d9e93c3c24b307625165e97c514f11cf4db5a4dc7ea7acf8fe738af1a86"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1138/nuon-lsp_darwin_amd64"
      sha256 "5bac067b371756792d0e70fd8b26c8fbd73d182f45e34a1aaf92c424cee406f4"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1138/nuon-lsp_darwin_arm64"
      sha256 "a58226f687a4ff42becb9d1d8b225e1830e5f9fb5e12aa714716f5df9bbc2f8f"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1138/nuon-lsp_linux_amd64"
      sha256 "2f54c80398d1af0c3d1fe6a1550e2f85f8195b532a0cd7d32c09673df5ce6997"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1138/nuon-lsp_linux_arm"
      sha256 "cd41ce227049ab0c20760827721d63b63bd915a2975678b705a4c3eae2e4112b"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1138/nuon-lsp_linux_arm64"
      sha256 "063e0716860ab3506a70b4948c16a6f75944d1b6abbf22f6e71fda74509a7c2f"
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

class NuonAT0191139 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1139"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1139/nuon_darwin_amd64"
    sha256 "a859d1f359930a9cbd1dee2ca90f84f09d9d68a585b687258de11793fce649a0"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1139/nuon_darwin_arm64"
    sha256 "183f8b505e5f330e64a0de911e87093dae6dd0065e5deba2dbb2ce69eb0fd1e0"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1139/nuon_linux_amd64"
    sha256 "b7e7655f7b07fe553411be9fc9aa6f92f0a382fcd2daafb9d0d74602abd03fa1"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1139/nuon_linux_arm"
    sha256 "39b236ec300d4fccb67b1ab0e7622a329b3fe6caca8172e4acbed33926d0c375"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1139/nuon_linux_arm64"
    sha256 "e11bac59f099262b1c6f4b7d327cf49f0b8be598f0ad243ce23d8a28a401eaad"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1139/nuon-lsp_darwin_amd64"
      sha256 "5bac067b371756792d0e70fd8b26c8fbd73d182f45e34a1aaf92c424cee406f4"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1139/nuon-lsp_darwin_arm64"
      sha256 "a58226f687a4ff42becb9d1d8b225e1830e5f9fb5e12aa714716f5df9bbc2f8f"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1139/nuon-lsp_linux_amd64"
      sha256 "2f54c80398d1af0c3d1fe6a1550e2f85f8195b532a0cd7d32c09673df5ce6997"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1139/nuon-lsp_linux_arm"
      sha256 "cd41ce227049ab0c20760827721d63b63bd915a2975678b705a4c3eae2e4112b"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1139/nuon-lsp_linux_arm64"
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

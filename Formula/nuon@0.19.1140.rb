class NuonAT0191140 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1140"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1140/nuon_darwin_amd64"
    sha256 "dc044405213dd54b1d33d37234ed13640242cc57b6ad13273e78ba27d298796f"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1140/nuon_darwin_arm64"
    sha256 "604fc686184f2bc66214abcecea588cf703395b6dc32e47152e9652fd5eb119d"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1140/nuon_linux_amd64"
    sha256 "3cbebbc5df324639a7ea4e7c14e3a350cdb4d458f1fbedb49cecb0e2d31ec86e"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1140/nuon_linux_arm"
    sha256 "f4d5eaafe10943d0db34b06a108c1bbfe61a2518357c60b76af364f3566bb2bd"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1140/nuon_linux_arm64"
    sha256 "12d51a5e4d4aba619ecd25dddbde76f2d3ed7b31689564833b62cefa952a7d3f"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1140/nuon-lsp_darwin_amd64"
      sha256 "5bac067b371756792d0e70fd8b26c8fbd73d182f45e34a1aaf92c424cee406f4"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1140/nuon-lsp_darwin_arm64"
      sha256 "a58226f687a4ff42becb9d1d8b225e1830e5f9fb5e12aa714716f5df9bbc2f8f"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1140/nuon-lsp_linux_amd64"
      sha256 "2f54c80398d1af0c3d1fe6a1550e2f85f8195b532a0cd7d32c09673df5ce6997"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1140/nuon-lsp_linux_arm"
      sha256 "cd41ce227049ab0c20760827721d63b63bd915a2975678b705a4c3eae2e4112b"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1140/nuon-lsp_linux_arm64"
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

class NuonAT0191137 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1137"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1137/nuon_darwin_amd64"
    sha256 "a93fc552e17319e7a853667e4dc88db31fc130e892a1f9b896215a225b26ec09"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1137/nuon_darwin_arm64"
    sha256 "d6f3eba4350dcd7f2129fb7f4b8380e35b6d89e80a0f9a846202505167a109b9"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1137/nuon_linux_amd64"
    sha256 "779d38be183d439f843ca65847fb8bfee9d3d0b75ea880fb7b7ddce6f76a042a"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1137/nuon_linux_arm"
    sha256 "0e0271da7c34b36893f36a2888420375e83a2ebe5f38b3a1cb91fe78184cafc1"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1137/nuon_linux_arm64"
    sha256 "d4502eaab25648ee71652bc532945610968d947c335486cafc0f9a0a53f7d067"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1137/nuon-lsp_darwin_amd64"
      sha256 "5bac067b371756792d0e70fd8b26c8fbd73d182f45e34a1aaf92c424cee406f4"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1137/nuon-lsp_darwin_arm64"
      sha256 "a58226f687a4ff42becb9d1d8b225e1830e5f9fb5e12aa714716f5df9bbc2f8f"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1137/nuon-lsp_linux_amd64"
      sha256 "2f54c80398d1af0c3d1fe6a1550e2f85f8195b532a0cd7d32c09673df5ce6997"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1137/nuon-lsp_linux_arm"
      sha256 "cd41ce227049ab0c20760827721d63b63bd915a2975678b705a4c3eae2e4112b"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1137/nuon-lsp_linux_arm64"
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

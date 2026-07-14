class NuonAT0191057 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1057"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1057/nuon_darwin_amd64"
    sha256 "c9acde03853d9ec74173504b4181838912528e5b53c8f72c141043ca09e72fef"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1057/nuon_darwin_arm64"
    sha256 "f2ecb2a08a97008a8d0b9ce077830731d8c2d0b2c6ae0177fde21305ea3a2312"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1057/nuon_linux_amd64"
    sha256 "27d527b6b628f43f827001b9c5288d5bcb462dcc665bfd2b4dccecc584995a47"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1057/nuon_linux_arm"
    sha256 "5f69a2e20df3737af8037da7258957fcdc845397d7d9297612a013f684789193"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1057/nuon_linux_arm64"
    sha256 "fd53786d17a432afcd69efc039d0f7351bc9d36472b5e727abbea40ce8dab9ed"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1057/nuon-lsp_darwin_amd64"
      sha256 "9c6bf03ee855956feb074cb42f7cf4c533f58d77407a6c1f2321b032f59a14cc"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1057/nuon-lsp_darwin_arm64"
      sha256 "ec95054c76c7e58d9af3b12b07b810e29dc5f9eff2f91991efb5fe57f8103ad4"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1057/nuon-lsp_linux_amd64"
      sha256 "a7066ea18ace26c8ded42b1ca5881f5209566271a8474407a252c024582e7c99"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1057/nuon-lsp_linux_arm"
      sha256 "ecca4c4ceb8c9589cdb23fd097d338ae8f4cfe2d0b9b743d62ec4cc401ee5dd3"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1057/nuon-lsp_linux_arm64"
      sha256 "7ccee00185d89852bacdbc4f2c90fd5083b022467d41fe3cf57fa76da4a94b62"
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

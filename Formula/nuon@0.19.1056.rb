class NuonAT0191056 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1056"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1056/nuon_darwin_amd64"
    sha256 "5d9604b67c90f00e41343da72f94f8b2681d4686e9b28f7a50cf5e5494e73770"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1056/nuon_darwin_arm64"
    sha256 "f807a3a40d110f14556e3f8f11f3075cce6a41bf986f69254ea642893743bdf3"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1056/nuon_linux_amd64"
    sha256 "774c62dcc99e78268c1b63894e6fa44cb8f7c3976dfe8df15aa8a3ec5d8fa40a"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1056/nuon_linux_arm"
    sha256 "47edd84a9015c9816705a69c8dbe6e61d7c04a33235d18678c3133269eb2ce7f"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1056/nuon_linux_arm64"
    sha256 "b1ed9abdeaa0207cb2bfc1e914ee9482bbeb18617d4899c8f9c2acc4620e4451"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1056/nuon-lsp_darwin_amd64"
      sha256 "9c6bf03ee855956feb074cb42f7cf4c533f58d77407a6c1f2321b032f59a14cc"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1056/nuon-lsp_darwin_arm64"
      sha256 "ec95054c76c7e58d9af3b12b07b810e29dc5f9eff2f91991efb5fe57f8103ad4"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1056/nuon-lsp_linux_amd64"
      sha256 "a7066ea18ace26c8ded42b1ca5881f5209566271a8474407a252c024582e7c99"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1056/nuon-lsp_linux_arm"
      sha256 "ecca4c4ceb8c9589cdb23fd097d338ae8f4cfe2d0b9b743d62ec4cc401ee5dd3"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1056/nuon-lsp_linux_arm64"
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

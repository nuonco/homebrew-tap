class NuonAT0191055 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1055"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1055/nuon_darwin_amd64"
    sha256 "f95f08035023598d45eb820d0b44130f24538d0e63c8870d2bc5f51e8757c631"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1055/nuon_darwin_arm64"
    sha256 "05d742701ca244a33045234a9075c7f734853c4158a1135f050507f45e1cae81"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1055/nuon_linux_amd64"
    sha256 "574dc096208c6d3c349067cd6b3397c254b8e98febc4bf87d272f69f6d1bf916"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1055/nuon_linux_arm"
    sha256 "292deaed808a37ccc544a618a4ce2f8154f3152ac3f146ebf241e8d5f1f25234"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1055/nuon_linux_arm64"
    sha256 "fe3f3e47f790bd6e9ac6c63d12177bc99b7aabc6c4c4312960c52527eda14973"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1055/nuon-lsp_darwin_amd64"
      sha256 "9c6bf03ee855956feb074cb42f7cf4c533f58d77407a6c1f2321b032f59a14cc"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1055/nuon-lsp_darwin_arm64"
      sha256 "ec95054c76c7e58d9af3b12b07b810e29dc5f9eff2f91991efb5fe57f8103ad4"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1055/nuon-lsp_linux_amd64"
      sha256 "a7066ea18ace26c8ded42b1ca5881f5209566271a8474407a252c024582e7c99"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1055/nuon-lsp_linux_arm"
      sha256 "ecca4c4ceb8c9589cdb23fd097d338ae8f4cfe2d0b9b743d62ec4cc401ee5dd3"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1055/nuon-lsp_linux_arm64"
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

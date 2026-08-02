class NuonAT0191101 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1101"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1101/nuon_darwin_amd64"
    sha256 "db4198b38a4474a03d5024d587d4c7e929baf6c77c21b1be712811f2093e4064"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1101/nuon_darwin_arm64"
    sha256 "d000ebdc39e6c451668536e5d74b74d6d1eac7415c892c5a50a194cf7f9f0f77"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1101/nuon_linux_amd64"
    sha256 "55a008f72bd23d4f90ad914c6f3a2f576b6d626a55ebbcc66e87079f4c578de0"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1101/nuon_linux_arm"
    sha256 "ff854b261b32ddaac638f93c6fc9a6bad4f88ef04cc9a41bfd58f32a1cab42ee"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1101/nuon_linux_arm64"
    sha256 "e385eecd6e7f5d46374ce9395987a8ae0869ba339c02b75a81a5c67bb9994f43"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1101/nuon-lsp_darwin_amd64"
      sha256 "b84ee20370917d1b2ceab0f1a018cf0fe5276857bf371d0c46f35cff61acaf63"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1101/nuon-lsp_darwin_arm64"
      sha256 "2a9e8b886d08bb6649089aaebdb52b04bcc29ec05a88ed4c5dd3f7518a25919f"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1101/nuon-lsp_linux_amd64"
      sha256 "331d14bcc4b6a0f2a4624dd091faf9da395c60a616b8ec7c2699ecceabea11ae"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1101/nuon-lsp_linux_arm"
      sha256 "8bf80e42fd1a10fe8f85167709c3cebf2ed63eb57bfd7e7d001b08753499e471"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1101/nuon-lsp_linux_arm64"
      sha256 "ada73e3bc3363079839d6e52a704fcb1ea1e8789da6d8e14c7730de04abe11bf"
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

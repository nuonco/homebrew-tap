class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1256"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1256/nuon_darwin_amd64"
    sha256 "d3a3584f150cbd90de35cdec03ca6a0461f266aecb8caeab0ace5783034ff3ad"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1256/nuon_darwin_arm64"
    sha256 "8ce663fce43708092be5a5e105726fae2d1e3efff8a583f87635db8ae29b6b4e"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1256/nuon_linux_amd64"
    sha256 "60e355ffc72fcf5adf068e28b764cea5bfac085b3ea931438b2714ad7ad5cf37"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1256/nuon_linux_arm"
    sha256 "552c15d17c4287aa0bfd6be61dbac7424e2d4843804cda682906b9f8703ab9f6"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1256/nuon_linux_arm64"
    sha256 "7a210c0d0f9355e7d6ea211a12273237a87d715f6a16047e314591a25036a4d0"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1256/nuon-lsp_darwin_amd64"
      sha256 "58c93d3cb36762bc8f764e16547491ef314f7f6429f5e493deace6e99abbe761"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1256/nuon-lsp_darwin_arm64"
      sha256 "8909b8b82bbb782f4a5251d204c957747bff2ffddd4213ee8f83524ca4b3ee85"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1256/nuon-lsp_linux_amd64"
      sha256 "d4e652bc72b24cdb23c369b5d3e692d55319184118a8cec2ece782f30744dc14"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1256/nuon-lsp_linux_arm"
      sha256 "a96934b45c100702efc757e109814007104e77fe21ed432021e5b7b00aca6824"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1256/nuon-lsp_linux_arm64"
      sha256 "50f0d9c98be2262c50886d70641b0d19e924320a45ef093694ca0e9a80a6eada"
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

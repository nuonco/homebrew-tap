class NuonAT0191064 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1064"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1064/nuon_darwin_amd64"
    sha256 "665581251a7c24ce212378ef8bd3e959ced8aa61afce868bb943a7f4cbd9c449"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1064/nuon_darwin_arm64"
    sha256 "c1832f2fc0047e49653e612c18f569f0e6ad4049d4a3927e88c085f2fd624f62"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1064/nuon_linux_amd64"
    sha256 "5579b62d0327865defeae158418996032f8bf4192e8b7faa32660a26cc3da49f"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1064/nuon_linux_arm"
    sha256 "8541e58b444ac21ecb4736750f0789084a441ad8166fe7f24b78411347e9b4d8"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1064/nuon_linux_arm64"
    sha256 "607ae7930d081b63442004166c5531c300955609d32cfb0e59aa937d9dc2d280"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1064/nuon-lsp_darwin_amd64"
      sha256 "5e68ae734b1b18a9c55404c7c940f118901419b7db77ba7c7e8639ef85c53ce9"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1064/nuon-lsp_darwin_arm64"
      sha256 "25cfd2a430328cd92431b4fedf3180835abf49f65c1c997cb4a4f64c4f472c25"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1064/nuon-lsp_linux_amd64"
      sha256 "dff1c433dd3b5b5ae8bed4bccc67cc77c15f4fc0e058cdf4454cc7f2a633e8c0"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1064/nuon-lsp_linux_arm"
      sha256 "6f1570acfd6be88ab53ac7c564a75f092e25fa852c4957f174a1b39cbf9b5b59"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1064/nuon-lsp_linux_arm64"
      sha256 "a5adb6abd8fa71dc4b02fc91eef9da8218f689c4fc31cdd2ee5d09ecc0a4861a"
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

class NuonAT0191259 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1259"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1259/nuon_darwin_amd64"
    sha256 "5d47c3169ff7511d79ea75d4736f8371f9a4e6d52333cdc2c3d0a041efa30c0d"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1259/nuon_darwin_arm64"
    sha256 "11ac9ff1e838c73219aa73ae4d06f1facdbf0d17de8cc9032d5fccd6a5d9c3d2"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1259/nuon_linux_amd64"
    sha256 "745539de7bf3dd8afc388984ee45ca804744cb2eba4eda856830af9e3cd1c701"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1259/nuon_linux_arm"
    sha256 "015e5d0d023a15d38020cd9f37719114f50020da6d779db535769b1d56ecbe9f"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1259/nuon_linux_arm64"
    sha256 "b9d167af44e99a5d2b784221f5e6c795831bc7c167cb3eca718c30a6920b5580"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1259/nuon-lsp_darwin_amd64"
      sha256 "108124cc57ac7c9b1a051012a43d487b0aa43a34230124614c6ab953b3aa9490"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1259/nuon-lsp_darwin_arm64"
      sha256 "6ed223adbfed6d1328d882be04d94f67b217b11a4ff679078e77d02227b19ecc"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1259/nuon-lsp_linux_amd64"
      sha256 "9aeb602642f2cbf4c1de6db9d3b4001ec24d21c6bf00a22a7b349580bca11507"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1259/nuon-lsp_linux_arm"
      sha256 "2beaaeb4df1ca88e27f83ddf82d13badf7666f73bc86a740bddabb19a629a4ff"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1259/nuon-lsp_linux_arm64"
      sha256 "840e61151528f64033af4bc1fc5d4c7c8b52b0e1634a272c9c20a51cc8ca1b62"
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

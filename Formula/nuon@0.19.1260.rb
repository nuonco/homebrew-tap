class NuonAT0191260 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1260"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1260/nuon_darwin_amd64"
    sha256 "a2ba0d0ee3c77996d2e6af5e613defdc17ebfd54b8f9ba167027f52c0cb1bbfa"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1260/nuon_darwin_arm64"
    sha256 "e45aced57ca3ac2355fdb933e8d5b56685527d868c5a43da103398ff971ede8f"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1260/nuon_linux_amd64"
    sha256 "943204e7c4bffbfe560522a81ae067806085f48fb87d9d4dc4df4c244ce1cdc4"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1260/nuon_linux_arm"
    sha256 "d53e88b7ba9042ca9ebb120eb6cc6004db868ebc87fba46e3063bc68fc087315"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1260/nuon_linux_arm64"
    sha256 "a9e40bbe10da5ce50ac89ac44536470d27e3091e9ab81f0d6f389b51cdb806ac"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1260/nuon-lsp_darwin_amd64"
      sha256 "108124cc57ac7c9b1a051012a43d487b0aa43a34230124614c6ab953b3aa9490"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1260/nuon-lsp_darwin_arm64"
      sha256 "6ed223adbfed6d1328d882be04d94f67b217b11a4ff679078e77d02227b19ecc"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1260/nuon-lsp_linux_amd64"
      sha256 "9aeb602642f2cbf4c1de6db9d3b4001ec24d21c6bf00a22a7b349580bca11507"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1260/nuon-lsp_linux_arm"
      sha256 "2beaaeb4df1ca88e27f83ddf82d13badf7666f73bc86a740bddabb19a629a4ff"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1260/nuon-lsp_linux_arm64"
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

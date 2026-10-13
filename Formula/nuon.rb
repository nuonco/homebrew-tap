class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1239"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1239/nuon_darwin_amd64"
    sha256 "f2696dd7193e21a2bdbff5946e167de799a073a4ba1af23b54ac28bc39a4872f"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1239/nuon_darwin_arm64"
    sha256 "43f6ff233be68b9f8a606226cd1d55265451d225ecca7a9b5cf86c87ec9090dc"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1239/nuon_linux_amd64"
    sha256 "4bf6786487f7f979b52e5e2ee19bec9611aa892482966dbffdd911ca9033d535"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1239/nuon_linux_arm"
    sha256 "8cc9c1447f94ae0b04b12ffa6873da16e4314ad765ba66dac1aa32049f03f1a9"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1239/nuon_linux_arm64"
    sha256 "9dd9334224e25e79d6063705aef37bb36d320f96b0852a52b2b9375fdab15550"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1239/nuon-lsp_darwin_amd64"
      sha256 "9c9ba7a00bde0c8bb85996a40b8b6ababa3dfd28bc50352fb288ca27c29b26b5"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1239/nuon-lsp_darwin_arm64"
      sha256 "b35ac87c1b987875dc4bd3a679b59f0b4221871fba80adf993115616af07f1e0"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1239/nuon-lsp_linux_amd64"
      sha256 "d7b3c73e67ddd57fe0c6a0c907906fe2a6ccf69430ba1cc4b6be24a7ef4c218b"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1239/nuon-lsp_linux_arm"
      sha256 "8eaff1b6bb02f0bea7a0630c465e46254dd880b5d5474b3ced260ae1d37459c8"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1239/nuon-lsp_linux_arm64"
      sha256 "a8745b7721df75ab4f80494077656c9d084db895e64900692cc6524385c038c7"
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

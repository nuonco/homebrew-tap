class NuonAT0191207 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1207"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1207/nuon_darwin_amd64"
    sha256 "d641f3d2b9e4acaa4da6d5d7210730d1c37484969a1ab0c39173945e371786a3"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1207/nuon_darwin_arm64"
    sha256 "a8a60b2aae112020d12030e07059153aaf61d64483045639197181111e50bbd4"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1207/nuon_linux_amd64"
    sha256 "e67fa81f9970398bee81a6301b48ee7653e7a79f484b88f6d6e7f3e8ba6f50c5"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1207/nuon_linux_arm"
    sha256 "3c6715ed9a43155339445d6f9e957b4533b83fab05a3fd9300bd8fb4f9b1d50b"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1207/nuon_linux_arm64"
    sha256 "65e94f98f766082271bdd119d2face917976389885552130826d1c0572158c20"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1207/nuon-lsp_darwin_amd64"
      sha256 "bd035a81862fc22925c55094577082f78769ebef31a8acfedba4582a4d2f579a"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1207/nuon-lsp_darwin_arm64"
      sha256 "b7b58c0d7f81f9929c8fca8be84a7546a693090e1545f99791fdeafa5c0871b4"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1207/nuon-lsp_linux_amd64"
      sha256 "3f20edf9898988d1832c44de98c4b3a7abceaf585ef316ead80e2ffe13c24ad4"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1207/nuon-lsp_linux_arm"
      sha256 "c815abacd3061cc190def81098b4899bfe08698e1cd3e2111992b477fc58a7aa"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1207/nuon-lsp_linux_arm64"
      sha256 "45a2111048f87e0ad2aa02e8e9e337298ddc0bc96a32d3b89afce20d8f7494fa"
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

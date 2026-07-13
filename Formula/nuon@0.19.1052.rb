class NuonAT0191052 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1052"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1052/nuon_darwin_amd64"
    sha256 "c8b88eb01ba51c78142a7e4602e06b53a90103b4bef4137d3a79c875f510a1c9"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1052/nuon_darwin_arm64"
    sha256 "21c231681004875f25982227d8f860bc79c86c0f4cb9c947775e785758b516d2"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1052/nuon_linux_amd64"
    sha256 "88819b6f1f8668b737a3d2c1d3a653e23b1e5e663493405280fa86fd2409e410"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1052/nuon_linux_arm"
    sha256 "00cc90201cf47dc7144765b0799beef2616f6c0142e54c7a768c70fced0fb312"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1052/nuon_linux_arm64"
    sha256 "bdf92d634f5c448f99814f1f9e789b4a1f5694e080878ffdbe7d98fee53128ed"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1052/nuon-lsp_darwin_amd64"
      sha256 "aebb1adb69efcfb8198ff6fbb12b9b936ec1f3fd4d346436220756449f8f027f"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1052/nuon-lsp_darwin_arm64"
      sha256 "430c7c8a18898a75347c84a5db3e8929bdcd68d92a800cca8940a2c8ba0fbc84"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1052/nuon-lsp_linux_amd64"
      sha256 "0dc1f4e93dbb89aef2cdefa3340eced596a653c7034ec9c1634450c39830b5f5"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1052/nuon-lsp_linux_arm"
      sha256 "f8b4360c42dc7eeb5de12f1dfade5fbcad0ee8f5a4ad8630f959480be82496a4"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1052/nuon-lsp_linux_arm64"
      sha256 "9388d87ae8038538c58f4c61b6362ca66a6aac4f16d950379e55fc63a97309f3"
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

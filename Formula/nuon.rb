class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.941"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.941/nuon_darwin_amd64"
    sha256 "427b3be7389e0327e9fe737f20c42161f97e5b9ca951952078fb1f648a5d53be"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.941/nuon_darwin_arm64"
    sha256 "d1a126ab3dc5b624211e2253d39bd8d86deb489cc3da8651ca72549bd24b172d"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.941/nuon_linux_amd64"
    sha256 "6d8c065222e00ed587b5b7bafb8ab63f132c60e3c951195cdc0dd7cd07f7ee6e"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.941/nuon_linux_arm"
    sha256 "b37ecf28df8143e484126b26ac84fd306ff308f03934964b815127a87261b476"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.941/nuon_linux_arm64"
    sha256 "dc4e4e8c0350a9fa4cf47b23ff0b26942caf740349ccb56874f3c6a0aac9aafd"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.941/nuon-lsp_darwin_amd64"
      sha256 "d2e34c26829320571db4c09464b2665fa5a3529b064f102c3669369e895ed84c"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.941/nuon-lsp_darwin_arm64"
      sha256 "47fb9de4d7949b669994401bbbf5a1a76b68a15f02bc62e6841814a3003333d8"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.941/nuon-lsp_linux_amd64"
      sha256 "65ab9528ae09053eb0b233d9acfa6fd256d86696a9b8cb14f641ecedec9d711f"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.941/nuon-lsp_linux_arm"
      sha256 "a586a46dff1fcad22d8a6a91ab81ac9e9c958b76fd74cc3ab797e85c6dc597bf"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.941/nuon-lsp_linux_arm64"
      sha256 "7198b48323fc2735505e2660bb90c6f23c64e7decc9a1ff23693793bcaf60146"
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

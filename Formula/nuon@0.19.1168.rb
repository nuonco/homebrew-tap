class NuonAT0191168 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1168"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1168/nuon_darwin_amd64"
    sha256 "d4974ab6c65747b05128dd3ef2a811dba256e40f91f8d2d577e080f7675a5d3b"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1168/nuon_darwin_arm64"
    sha256 "ccd7aaed8c3065b1ccf08045cf7c4bc8d15d5529ed6300ccb78143630c6410ab"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1168/nuon_linux_amd64"
    sha256 "e4dd1d43bbdb23b5b520a1d286fa52d0eb19e1bd5b69e36e7856bb8780240378"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1168/nuon_linux_arm"
    sha256 "82b68b9a9fc2ad958289dfe81c0ff6990d6fd55986c5b4952fcfa63eb65ba499"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1168/nuon_linux_arm64"
    sha256 "908846611396e3d09b842195f5b0237f5fd7500b4270ecc08150d25a6305deb7"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1168/nuon-lsp_darwin_amd64"
      sha256 "6a95fe2d41165c9cc508e40813865b20e71b04a937e1f7d4af698c7ca983a648"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1168/nuon-lsp_darwin_arm64"
      sha256 "ddaa7b9c1c4135b74f671a2230b53767466c231334abe35456359076fa84c3ff"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1168/nuon-lsp_linux_amd64"
      sha256 "da9e6dd33d8e9cd052d36a2ed8f9509f80fa3c155e6e5d2a629696b23dc06a9b"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1168/nuon-lsp_linux_arm"
      sha256 "5990f0eebdc375e92a317bbd946365e32bb0661c43dff027340a3fdd5919af6b"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1168/nuon-lsp_linux_arm64"
      sha256 "01f1608c2b649621683f7c5d4720d55ff3ab1bca07c4387fafddfe0e594d92d4"
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

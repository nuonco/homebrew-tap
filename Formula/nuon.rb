class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1271"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1271/nuon_darwin_amd64"
    sha256 "588d9c1bc7b0f4b7411729aacf3b161f88d2aa4de01c7c63c8da36ff0ce31fa0"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1271/nuon_darwin_arm64"
    sha256 "b9302ebadddf4392647265a2891de34c83a80787d484539651fdd14127e02d4a"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1271/nuon_linux_amd64"
    sha256 "6f5a0bd0fff80b461d59eb8d3d5d99d6264285c455e6d02c3efa3593db1b3350"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1271/nuon_linux_arm"
    sha256 "7a182d1a78b72582cb7de4a4df596c9493dcb0f908239c1d2ce344578c40d8ca"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1271/nuon_linux_arm64"
    sha256 "ef4e4cb0f1e7fc97ba97cd01eec10b69b1992919234ee224ee4bf914b900322b"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1271/nuon-lsp_darwin_amd64"
      sha256 "4c5f476c20a014b6fe00cd812297ccda9ff6a7373bb0d5cf732bf9ff9c0c14d5"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1271/nuon-lsp_darwin_arm64"
      sha256 "11f9960e7689d9e5bb0ad70f69960d7dc83b938049392d656ca8a072788641ba"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1271/nuon-lsp_linux_amd64"
      sha256 "4ef4588b4177e687e90a2819ff332f2a601055df0146e4cab6a2000db2402faa"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1271/nuon-lsp_linux_arm"
      sha256 "e0077a864a15675d395c299ab480bf7fc498e3689091cb2908513ea40bbc3699"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1271/nuon-lsp_linux_arm64"
      sha256 "618dfc7c6748f33c8fa50ecf5ee14199aa52c47cf9ab713007b4a0e994ff2f4d"
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

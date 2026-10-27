class NuonAT0191272 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1272"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1272/nuon_darwin_amd64"
    sha256 "877d0af612476d63b605ee1a2ad1152fe30448af57a8acb1ebc55085cdebc97d"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1272/nuon_darwin_arm64"
    sha256 "9bd5eeeed9018c699f6bf6942952ec4ab4cc81d5d5d7424ef661c6fd0071c46a"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1272/nuon_linux_amd64"
    sha256 "97f0a7f6f7539c113569be6be52a40ddddd0924d10481e6359b75f9790d32ec2"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1272/nuon_linux_arm"
    sha256 "af02be84ea7aa3819bf71613559413c53d6b7053727602f7c9447c50f7ca0873"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1272/nuon_linux_arm64"
    sha256 "bab036b6098e0f60e8d1de6cf15c199f78a1105b7233b0ab41f1a3f4ec9eaf49"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1272/nuon-lsp_darwin_amd64"
      sha256 "4c5f476c20a014b6fe00cd812297ccda9ff6a7373bb0d5cf732bf9ff9c0c14d5"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1272/nuon-lsp_darwin_arm64"
      sha256 "11f9960e7689d9e5bb0ad70f69960d7dc83b938049392d656ca8a072788641ba"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1272/nuon-lsp_linux_amd64"
      sha256 "4ef4588b4177e687e90a2819ff332f2a601055df0146e4cab6a2000db2402faa"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1272/nuon-lsp_linux_arm"
      sha256 "e0077a864a15675d395c299ab480bf7fc498e3689091cb2908513ea40bbc3699"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1272/nuon-lsp_linux_arm64"
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

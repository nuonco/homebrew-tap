class NuonAT0191295 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1295"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1295/nuon_darwin_amd64"
    sha256 "936d2c58ca3cc5cd93c2eb9b16c2de83010ee0fc6fb35bb21d88720ad9956451"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1295/nuon_darwin_arm64"
    sha256 "888e38fa1a0813bd9dbcdd501edbe2e3694a422a385e0a55dee47b0b57203550"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1295/nuon_linux_amd64"
    sha256 "ff73629a0b82ba9404d799f9e6d374875509c3ffbef76685ba8d1019ee348499"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1295/nuon_linux_arm"
    sha256 "d921568cc73c58e09db9874ced374a82b370368d2110acf6d7b213e6dceac42a"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1295/nuon_linux_arm64"
    sha256 "491783bcf8a03462827faf08526d44108acb1638dcf79b773f622b749da4c88a"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1295/nuon-lsp_darwin_amd64"
      sha256 "b4c5ffa16a39a6c5e009c54c7353eb9a1e8b34d6179429fc6dafab057073eb53"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1295/nuon-lsp_darwin_arm64"
      sha256 "8678f0f5adf498987972ebbd3c34e4ad0d3db5d1688432de158e58002dff9a9d"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1295/nuon-lsp_linux_amd64"
      sha256 "64ed2af551207bfa72480a667b69afb5edeb9ea328c41a8e95c798fd6934efa4"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1295/nuon-lsp_linux_arm"
      sha256 "d654aebd6adf0e2e64d9ab06431c402db12ce170a7eacceae27a5d2f9953a1e4"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1295/nuon-lsp_linux_arm64"
      sha256 "f14bf5250173bf66f3fc8259090d662eca1fb4314e8fbed3a8204264e3456e34"
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

class NuonAT0191294 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1294"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1294/nuon_darwin_amd64"
    sha256 "09ad5dafead991eecb6c5e06a682bce4716439e40afb62aca6cea0f54bfeafb3"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1294/nuon_darwin_arm64"
    sha256 "47f719ed9e2eac01e78019a16ea25058ade358f3ce8570717d0e062b30d96497"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1294/nuon_linux_amd64"
    sha256 "432235e4804c761af9cd187cf35817bc885f8d3af0461e174a424318edce4b08"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1294/nuon_linux_arm"
    sha256 "f4821d0819f3d38f7559c6de95c6d22beca1de894adba085044116bcbb91b2aa"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1294/nuon_linux_arm64"
    sha256 "9d9cba9a5d18373f376e9f8094cfe635a5d00af9ea4a713a1c02de4f12088998"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1294/nuon-lsp_darwin_amd64"
      sha256 "b4c5ffa16a39a6c5e009c54c7353eb9a1e8b34d6179429fc6dafab057073eb53"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1294/nuon-lsp_darwin_arm64"
      sha256 "8678f0f5adf498987972ebbd3c34e4ad0d3db5d1688432de158e58002dff9a9d"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1294/nuon-lsp_linux_amd64"
      sha256 "64ed2af551207bfa72480a667b69afb5edeb9ea328c41a8e95c798fd6934efa4"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1294/nuon-lsp_linux_arm"
      sha256 "d654aebd6adf0e2e64d9ab06431c402db12ce170a7eacceae27a5d2f9953a1e4"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1294/nuon-lsp_linux_arm64"
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

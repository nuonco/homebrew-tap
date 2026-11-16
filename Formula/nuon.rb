class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1296"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1296/nuon_darwin_amd64"
    sha256 "470ad65347a5bd0dab0ccdda75e2c98e6632c0da0856b8ee7aed39a57dea4efd"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1296/nuon_darwin_arm64"
    sha256 "6e6bff27f084fc3248d6a4431c7b3f093936bdc9e00bd0d8205e0f60c1e9d949"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1296/nuon_linux_amd64"
    sha256 "40d0aee662ffa4df8663e645e20861c356c2315808bc7d2d85068686e8a930ca"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1296/nuon_linux_arm"
    sha256 "93af9d7a743325e2e41cc20c8b589755e3b4ed8d26be6a1f20fd203c70cec8b0"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1296/nuon_linux_arm64"
    sha256 "0ccdafbf65d73fc4814cb2649fcca0971e7efa79ca5b17dec43c14c8d9b9eb04"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1296/nuon-lsp_darwin_amd64"
      sha256 "b4c5ffa16a39a6c5e009c54c7353eb9a1e8b34d6179429fc6dafab057073eb53"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1296/nuon-lsp_darwin_arm64"
      sha256 "8678f0f5adf498987972ebbd3c34e4ad0d3db5d1688432de158e58002dff9a9d"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1296/nuon-lsp_linux_amd64"
      sha256 "64ed2af551207bfa72480a667b69afb5edeb9ea328c41a8e95c798fd6934efa4"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1296/nuon-lsp_linux_arm"
      sha256 "d654aebd6adf0e2e64d9ab06431c402db12ce170a7eacceae27a5d2f9953a1e4"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1296/nuon-lsp_linux_arm64"
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

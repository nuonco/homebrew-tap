class NuonAT0191069 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1069"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1069/nuon_darwin_amd64"
    sha256 "0898969ce43ef810ab22d8ee6f6cda014b97c243acabea50b9546bb21e97a1bf"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1069/nuon_darwin_arm64"
    sha256 "3119858652b74eb73ec632789dc4d4aa35be63e07f8e24894e48850482828de7"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1069/nuon_linux_amd64"
    sha256 "99f095098fad0a903d34b2cb9dcd34a9bfd37d0981cd4c4255b3c00d3cfa4e30"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1069/nuon_linux_arm"
    sha256 "b48c56c415063a3f311b2c87ddd2fa39bd77c571f5e8b3f7244def1e57640d18"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1069/nuon_linux_arm64"
    sha256 "ba18ac19b4ff085aa05201362c3d9aa34d4d60f43a34f33eed26e67910d38cc3"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1069/nuon-lsp_darwin_amd64"
      sha256 "1256a72b71507e45926c4f9ecce72677764613c4d8d1f16a515c98afc7861913"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1069/nuon-lsp_darwin_arm64"
      sha256 "05ef3c726926a77d6624ddf9216a1256b05e7732c3acf6aa2f89c5565fabb507"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1069/nuon-lsp_linux_amd64"
      sha256 "5677447c20160ef45edc16c83c42410f08d6f5411ae485e8ffb009a1e2f94a19"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1069/nuon-lsp_linux_arm"
      sha256 "33f4a50a1db4eb065e5dde413a1ac32cf273caf2fecc806963ae6d8c7c213c2a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1069/nuon-lsp_linux_arm64"
      sha256 "219823d8bd4c77fd0bf96ae62d0b26fea8799331bfbe5e86551f0006968454d3"
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

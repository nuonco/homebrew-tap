class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.981"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.981/nuon_darwin_amd64"
    sha256 "8bc38cc7a09d4cfb51fbb19e22c6958f3c519b6319406eb8015ddf791ba94b4e"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.981/nuon_darwin_arm64"
    sha256 "e954af927c2490b8367268f3699761658472e6a4cf3ab06345d88333019d529f"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.981/nuon_linux_amd64"
    sha256 "2bae2a4fc9a63222783458670ef601f5d94fd6f9334eb1ecd7072c0bf2058e02"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.981/nuon_linux_arm"
    sha256 "dc27d4610526f1ea576b13926ae5c055c26d3bf4759e84c4d675e104a69f2372"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.981/nuon_linux_arm64"
    sha256 "e4bf737d62428c6e8eb6aa517d01f6f3181a06908b259a52092d6235727a3754"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.981/nuon-lsp_darwin_amd64"
      sha256 "2cdaba386cda2f8c54e207098d7e4d92875109bfbf36006481645384a3ddefb2"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.981/nuon-lsp_darwin_arm64"
      sha256 "ccdc9eeaf30e615ee0e5b937dbb849c3c183e0675a458c8a335ea3097c6e1f49"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.981/nuon-lsp_linux_amd64"
      sha256 "bb895702d9b5313ef6197738bfa18e5bb5aa725242031ab684e31c875be19ad8"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.981/nuon-lsp_linux_arm"
      sha256 "f35e046a77fb89077ba9b8a77a96267552200101d6508223cb2beb8193812545"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.981/nuon-lsp_linux_arm64"
      sha256 "198e9512fd2ddadc846a2e8d91c90612e5cfdb9c2bb8a5c570112379160b491a"
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

class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.978"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.978/nuon_darwin_amd64"
    sha256 "f75bed918b58cb7f1ec1dad4705d525dc150debe8589b94d3c462e3d3aaba29e"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.978/nuon_darwin_arm64"
    sha256 "bd9fd6643d1e864d58eb27e81e1ebb9a6c1364fd33811365208cb6bb0d98f65e"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.978/nuon_linux_amd64"
    sha256 "1d074d60b3b0d883a77d4c320413a91151ca4c0dcc07a17cc5a9675fa3df2434"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.978/nuon_linux_arm"
    sha256 "d3dd89925c5cf2b3b9831812ac0dc472d7b25a517a758ce74cc8ed6f7f02d333"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.978/nuon_linux_arm64"
    sha256 "cf16776a2734e44b1088dc490bad9041cbfbdc94b6af2dfeeb180377f818ccea"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.978/nuon-lsp_darwin_amd64"
      sha256 "2cdaba386cda2f8c54e207098d7e4d92875109bfbf36006481645384a3ddefb2"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.978/nuon-lsp_darwin_arm64"
      sha256 "ccdc9eeaf30e615ee0e5b937dbb849c3c183e0675a458c8a335ea3097c6e1f49"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.978/nuon-lsp_linux_amd64"
      sha256 "bb895702d9b5313ef6197738bfa18e5bb5aa725242031ab684e31c875be19ad8"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.978/nuon-lsp_linux_arm"
      sha256 "f35e046a77fb89077ba9b8a77a96267552200101d6508223cb2beb8193812545"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.978/nuon-lsp_linux_arm64"
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

class NuonAT0191164 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1164"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1164/nuon_darwin_amd64"
    sha256 "d07728e115fb0e9acdfb0f785adafe403823530bd49d24aebfc0416b5a1cd1cc"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1164/nuon_darwin_arm64"
    sha256 "01e927e78622910e1f3aa313c95a3285a34a1d4f9c74091bf6976cbf6ac46bbb"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1164/nuon_linux_amd64"
    sha256 "fea311ceb0228ea05191677ac252e8e1eb50f74e7a074955363d8c0f406afa81"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1164/nuon_linux_arm"
    sha256 "55e326c9202890e78e410592418880f8e7eec83a532f045c817cf5c3188aad9c"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1164/nuon_linux_arm64"
    sha256 "21103f82ec6b278e6d73cfa69ac9c323e515633b461285179ab99ace89241f90"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1164/nuon-lsp_darwin_amd64"
      sha256 "6d7fc4262bf824cc9850c513c421496ec9472ae3d4da996a090fdec43b5a05c8"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1164/nuon-lsp_darwin_arm64"
      sha256 "a04e67f97ec749af3df9c5e0ffde1ff09ed7fdae7f750c2a4c081bbc8557b4b2"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1164/nuon-lsp_linux_amd64"
      sha256 "f31a958be2faf7876a73d78407c498bf6cfa83ab66d8c95a7ca6d4e4d982d7f7"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1164/nuon-lsp_linux_arm"
      sha256 "2b23012f92ec72b1f9feaec87a8913c651748bd3555ee1aeaffb7828b0742203"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1164/nuon-lsp_linux_arm64"
      sha256 "5cac9c0b6845580803d332d0fd93aa7a1f95b94c1977828f7507ac5c861a9b33"
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

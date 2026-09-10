class NuonAT0191173 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1173"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1173/nuon_darwin_amd64"
    sha256 "5498f248069b69c90140a03bd6ec585f4fbc8880bf8e8969167a37577e818514"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1173/nuon_darwin_arm64"
    sha256 "e7e71735060e76792147242e816513cf234636e0dbf4e1ca98c5e64e8b4b6255"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1173/nuon_linux_amd64"
    sha256 "bc3d6a2642a89de8d5b1e8f862cb3062c59c0b3e420c2b23daa0cb3d5bec5166"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1173/nuon_linux_arm"
    sha256 "98a1ff65d02d4b123cfd69ab2dd982750d7493da2571267d7c6ed5f9430cfb9f"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1173/nuon_linux_arm64"
    sha256 "093ddbbbe33468a362a246be44aceaff9301ca276b9d262739425e1073eeb6ea"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1173/nuon-lsp_darwin_amd64"
      sha256 "aa1c2e965db91d47dcc590ee8701f91812cac77a4c468e2de81ab98c03d9cb29"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1173/nuon-lsp_darwin_arm64"
      sha256 "a9aa2fa77878345ca6b946860cf8163b1b716f0fe7808daa2703eb4b73d7653e"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1173/nuon-lsp_linux_amd64"
      sha256 "8c225d4c9e94b9d89a50dd61326d0c2cc1aa7ddfa6f643398ddfaf692694da31"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1173/nuon-lsp_linux_arm"
      sha256 "cdad4e8ef9b436f690afd37c27ea994e18ce50053cd553a300a4bf459af76ec9"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1173/nuon-lsp_linux_arm64"
      sha256 "1a846c3df13c6c59d32b03623ab476c9ae666622eb3f1a1e57aaa40fd4da0772"
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

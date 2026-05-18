class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.947"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.947/nuon_darwin_amd64"
    sha256 "709f9cf1adb01810e4fab906e61c6e6131bc378e42d25d2f811cf70e137630ad"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.947/nuon_darwin_arm64"
    sha256 "f3df027cd3b6e235983bc714d684060f9c397a2f565a1331b40bce24f376c5b4"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.947/nuon_linux_amd64"
    sha256 "0d59fc2478068c36bcad4dd74203f6919e0db2207a83cb833576b31c26cd0b63"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.947/nuon_linux_arm"
    sha256 "c915206f286c1bd6081ecaa8dc1d34627acd90964327d29ceeaf25545c00240f"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.947/nuon_linux_arm64"
    sha256 "f7fd98a5740923869c4243197852c7d2e6d6803c13d6b0ae6dd184046e163bf0"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.947/nuon-lsp_darwin_amd64"
      sha256 "9d0ec8a6f674ff1c25ae009eb44a06db3bb5b52da585f71cdb0170d6988a1297"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.947/nuon-lsp_darwin_arm64"
      sha256 "40da8ee1fedb946640ee72aba2b2edf04796856879a205a1a6f6340270132002"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.947/nuon-lsp_linux_amd64"
      sha256 "5b448f6d890c0829f89c778be872740ca6eb96f5abcd63a121bf5688f3e2047c"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.947/nuon-lsp_linux_arm"
      sha256 "600eaebe05c3d6f127bb8fc60129407550dc589439eb496eb074e9cb8935f9bc"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.947/nuon-lsp_linux_arm64"
      sha256 "ebc028df861f9f86c4fb9d6bf7d605f028b8220f8ce4456f93e871e096af54b0"
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

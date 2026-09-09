class NuonAT0191171 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1171"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1171/nuon_darwin_amd64"
    sha256 "834a2eaa74b993764a622098643169da1acd4cc71ccdec473c0f6f63c33be128"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1171/nuon_darwin_arm64"
    sha256 "df4cc67ae8d8de6ca29af34a2e90b273cc9c872cc59d79cdcfd73f3f123d9459"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1171/nuon_linux_amd64"
    sha256 "a58da4890c89182e4862790850145671ebfda26abd4d63d3aaa019dbd7d0990a"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1171/nuon_linux_arm"
    sha256 "d03cf3323855db5095dcd3c3e196fc5d3af60be6448c10e5364f46578d23e36e"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1171/nuon_linux_arm64"
    sha256 "d9f9106c6053202d0782612f222bc1937c1edd3ed423aa923951e2c91b51a7f1"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1171/nuon-lsp_darwin_amd64"
      sha256 "6c7cbdd73cf93cd9e099031494e60b5e9f1e90905115adf32cc04b687c55737a"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1171/nuon-lsp_darwin_arm64"
      sha256 "5aa9922337ddc1bcbb8b9fc9f1d0d0f72db7e1849c728b19756f840e29a281ee"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1171/nuon-lsp_linux_amd64"
      sha256 "aa9278c72c9dd775b50130885c0cd4981a69ceec9f790bf5f96524a9068e6c9d"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1171/nuon-lsp_linux_arm"
      sha256 "8beabe5a2e94b907e436b37b710449e478f6251a7931a3982306bc548c31b2d6"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1171/nuon-lsp_linux_arm64"
      sha256 "9d839ac34d6b23e5feca78911521380fa47103f2e34621ef485a884b4f9612a6"
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

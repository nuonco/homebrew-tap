class NuonAT0191111 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1111"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1111/nuon_darwin_amd64"
    sha256 "93fe4a08fbb69e280e0bf607aeaf0dfac293299c6c612f04126c3d952b015f43"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1111/nuon_darwin_arm64"
    sha256 "359b6a65df55be2477e13459f9077a2b00891619ea6d9a788291deaa2a9ba5f8"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1111/nuon_linux_amd64"
    sha256 "b2cc8c2186a5e7be59423c6bc8eb6e5343813e2fc0873b79444f9b14b4a94985"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1111/nuon_linux_arm"
    sha256 "11c390d8048438b07f584fcd21afc00a00a2e3f65d1025b20b2af23ecf116eb7"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1111/nuon_linux_arm64"
    sha256 "6441dc19b008bf1b89b6307176b6b3be4b502cc7d934ac30fc800e38519b09b5"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1111/nuon-lsp_darwin_amd64"
      sha256 "7b8e52bc2290d0b3ac86e1a3110699fe70d843f334f791f58130d8742e33ea2d"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1111/nuon-lsp_darwin_arm64"
      sha256 "b4412224b5d117622e25978c3ce172cf424fc2d5eacf8d1964e9e69f40b4f534"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1111/nuon-lsp_linux_amd64"
      sha256 "7ae79fc836dc847a13072e4bf4e5b162b2354b488b62c7aebd0637a3b80d9d97"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1111/nuon-lsp_linux_arm"
      sha256 "576fe6b311b5b2330d752388b93ed63226e966076bf9867651069da53280a769"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1111/nuon-lsp_linux_arm64"
      sha256 "ff40f56346950252dac7ae960364f3b5e9df156ea23255e6661cedd54f391657"
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

class NuonAT0191112 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1112"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1112/nuon_darwin_amd64"
    sha256 "a90d68a9d59dee8621d847440d9afe380fa8b25a6d2c2a42a8914edd9502bf3d"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1112/nuon_darwin_arm64"
    sha256 "ace2de18f1e35d1a505db6586aca7e2eb103717d37c971d4ab8babfff2751323"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1112/nuon_linux_amd64"
    sha256 "d91238ccd7f7083c8db98b3b93b87e492a195eeb2694633d526affb2701ebb7a"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1112/nuon_linux_arm"
    sha256 "39c3721c5b3ad5ab32ec29a9fabfe29a07890f55f25d8af6dc0550696d3bf593"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1112/nuon_linux_arm64"
    sha256 "61716e7b395f6ab86960ae1303b0ebf5b384b3ec6bdbe72cf4cf1283ce56a0bf"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1112/nuon-lsp_darwin_amd64"
      sha256 "7b8e52bc2290d0b3ac86e1a3110699fe70d843f334f791f58130d8742e33ea2d"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1112/nuon-lsp_darwin_arm64"
      sha256 "b4412224b5d117622e25978c3ce172cf424fc2d5eacf8d1964e9e69f40b4f534"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1112/nuon-lsp_linux_amd64"
      sha256 "7ae79fc836dc847a13072e4bf4e5b162b2354b488b62c7aebd0637a3b80d9d97"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1112/nuon-lsp_linux_arm"
      sha256 "576fe6b311b5b2330d752388b93ed63226e966076bf9867651069da53280a769"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1112/nuon-lsp_linux_arm64"
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

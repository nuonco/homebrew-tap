class NuonAT0191071 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1071"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1071/nuon_darwin_amd64"
    sha256 "e31ae47d899981582ba0c07177651392482c09946230714cec20c25a41686c5b"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1071/nuon_darwin_arm64"
    sha256 "77d0d1da5199d906387b8b9d4881eb9f396b5026d95e78d3bb91c49e905b32a2"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1071/nuon_linux_amd64"
    sha256 "691b0913b7e0d38df6328d1493df5dc78236fe744d890f050d2ba373b1d43c40"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1071/nuon_linux_arm"
    sha256 "a8b6b86fdcb38f9b571d9a4e64b24d1ec859ea4943d616c5920cac5595279a8d"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1071/nuon_linux_arm64"
    sha256 "7a65438a26483092dcd136f8ae2ef7a5d74ba7c74b8ecaa675289227a5fe291b"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1071/nuon-lsp_darwin_amd64"
      sha256 "1256a72b71507e45926c4f9ecce72677764613c4d8d1f16a515c98afc7861913"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1071/nuon-lsp_darwin_arm64"
      sha256 "05ef3c726926a77d6624ddf9216a1256b05e7732c3acf6aa2f89c5565fabb507"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1071/nuon-lsp_linux_amd64"
      sha256 "5677447c20160ef45edc16c83c42410f08d6f5411ae485e8ffb009a1e2f94a19"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1071/nuon-lsp_linux_arm"
      sha256 "33f4a50a1db4eb065e5dde413a1ac32cf273caf2fecc806963ae6d8c7c213c2a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1071/nuon-lsp_linux_arm64"
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

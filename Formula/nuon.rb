class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.770"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.770/nuon_darwin_amd64"
    sha256 "9be0375078fd12d9b1a3a555e1e19f6fb7b94e28826f0270f9eaff66c267c271"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.770/nuon_darwin_arm64"
    sha256 "10049ba07a5a66ff86477fbbcd99cdcddb60759c406c75fa60f18125d0e9575d"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.770/nuon_linux_amd64"
    sha256 "c3194e0a49cfdc2af7eb1579c398ce9e3857bcea4c97dc6eccc1dad4b2d302ca"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.770/nuon_linux_arm"
    sha256 "0c0e03edff768531468a0529238b80cb360e595f2f5eb35ebfdf1616b112c349"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.770/nuon_linux_arm64"
    sha256 "715f11363d313f6086dab09155d8b0cce7df2c433dfaddbb65d0e08e347ed16b"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.770/nuon-lsp_darwin_amd64"
      sha256 "1cc44184596a77cb703dbfe48e37e27bc7e24beb7ece3e3c279735448b9a1462"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.770/nuon-lsp_darwin_arm64"
      sha256 "cbbfad5cb16749d5355eda6db6acf34fd2164cb5f69eefb260bccdd47cf33729"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.770/nuon-lsp_linux_amd64"
      sha256 "2490b759ece1a71dd473a0b6121c6f7126c27890f3aa212ffaa2279b0f77f5c9"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.770/nuon-lsp_linux_arm"
      sha256 "643a3bb571aaba1035101a45c1e37a904827b75a879ef64bff0e116befb4fbd3"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.770/nuon-lsp_linux_arm64"
      sha256 "5862c5c62aaa3bde0687fc98870b5c033b69f1c2b27eb9c5434e8e37fbce77ee"
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

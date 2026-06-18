class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1012"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1012/nuon_darwin_amd64"
    sha256 "083238dd9c8a7bdad17540756c505297fc7529013c1b0b57533462d3ce4f93f6"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1012/nuon_darwin_arm64"
    sha256 "bdcaee49b8c3881134337d3275419348243eddea5b7871a55f40253626b3e861"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1012/nuon_linux_amd64"
    sha256 "827a8de19394f7bbf4ba4cb89ad1ec2254fb4bba1e8e6171cc92a54ce2455c18"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1012/nuon_linux_arm"
    sha256 "6f72a85d00f2131a43430081a997e43d14fe91bf26250b41876a89409366bab9"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1012/nuon_linux_arm64"
    sha256 "4cc9700a1e353c9ad7edeba61f8c55e22be9ce0d1c203bed7422dbe04fc18766"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1012/nuon-lsp_darwin_amd64"
      sha256 "e5b343c6fea7b37c25f7b1d6551729d50c90c38d896e66fdce6feb75647c8a13"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1012/nuon-lsp_darwin_arm64"
      sha256 "f78a874423a71a7d74bc0f667a9150b2c03e69f6bb6ce1fd233c2eb1c2f85067"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1012/nuon-lsp_linux_amd64"
      sha256 "225bef4773ad2b349e6e5687fe110a7d229d4e9b57bc6ef7ac5d725b76e046c7"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1012/nuon-lsp_linux_arm"
      sha256 "0eab57a029d657c22ed222c8f298340447bb1a3f2d4979cefa79c7731e0be7ba"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1012/nuon-lsp_linux_arm64"
      sha256 "ca8be2e91caecf9bc29936f0a5ddb89e5e0d7bfc01e45132ab75522d5b08088c"
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

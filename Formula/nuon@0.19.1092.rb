class NuonAT0191092 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1092"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1092/nuon_darwin_amd64"
    sha256 "e9ae8944a3755bc0dbcb99ccaa2e483642b66902d53acb161b2b4ad7edcce206"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1092/nuon_darwin_arm64"
    sha256 "06ce69b85e7a5754827c0dd76abf8745c7fb62c7c63518043dbf501c6e74a522"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1092/nuon_linux_amd64"
    sha256 "1e0c10658144820b407144a79fd0dbd181312b94eb676d57324a0cb1f5397dbc"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1092/nuon_linux_arm"
    sha256 "7947c5aca812b20b66272a39c2e26520e9fa39391d50faa38b900b7ffc2f7810"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1092/nuon_linux_arm64"
    sha256 "f94c5778cae60f62708ae8ec363fe21c26a2da74bd52fe291b31ed40c45658d2"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1092/nuon-lsp_darwin_amd64"
      sha256 "518794c5244b57e56c1ae017f3502f1954cec1465013c6d97adaaa6209c09d3a"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1092/nuon-lsp_darwin_arm64"
      sha256 "39d5231f4870dfcff9d60ad6242e63ac2b06aab364e689a7acb5322aba12a990"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1092/nuon-lsp_linux_amd64"
      sha256 "e43c2edb6bebfd172e035c573889fe3bffd8a60ef6eb7f7e83dae90c0b3d3c62"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1092/nuon-lsp_linux_arm"
      sha256 "745941fcb24176fcffef25da0d8b38b3a7103e168aa8610641121385443b7a96"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1092/nuon-lsp_linux_arm64"
      sha256 "5d20f3e5c2057c1e655a1743841e41deb34402e4d63a461e71899aca1929f4fa"
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

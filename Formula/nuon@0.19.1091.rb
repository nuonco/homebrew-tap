class NuonAT0191091 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1091"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1091/nuon_darwin_amd64"
    sha256 "3b588261626a60b61c02cfae372b20a215815b5a12ace26c1b9b602c9947124e"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1091/nuon_darwin_arm64"
    sha256 "f48a5f2fd7b6f7af87fc7a94a59164d7e52531fb69d80af587ececca3c34afcc"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1091/nuon_linux_amd64"
    sha256 "b5aa14bb239cabd106f1a2a4e6f2f2989503a6ecf4f1d254613492c98678e5c7"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1091/nuon_linux_arm"
    sha256 "9d5b03701c2edbcd30ec669de3b4f02ca8b86660cf4f6cb21c33dab0fd7269ab"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1091/nuon_linux_arm64"
    sha256 "d43442e63d2b4c2e41e14ff328e7f0b4b52f32ade3e5ae76de62f32290bd660a"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1091/nuon-lsp_darwin_amd64"
      sha256 "518794c5244b57e56c1ae017f3502f1954cec1465013c6d97adaaa6209c09d3a"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1091/nuon-lsp_darwin_arm64"
      sha256 "39d5231f4870dfcff9d60ad6242e63ac2b06aab364e689a7acb5322aba12a990"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1091/nuon-lsp_linux_amd64"
      sha256 "e43c2edb6bebfd172e035c573889fe3bffd8a60ef6eb7f7e83dae90c0b3d3c62"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1091/nuon-lsp_linux_arm"
      sha256 "745941fcb24176fcffef25da0d8b38b3a7103e168aa8610641121385443b7a96"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1091/nuon-lsp_linux_arm64"
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

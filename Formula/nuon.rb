class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1027"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1027/nuon_darwin_amd64"
    sha256 "b8f58ef5280ee09f0c6b783c1f43171fbbb43b3ac723aa60068f0c6b643e6405"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1027/nuon_darwin_arm64"
    sha256 "4e15ecce5a0156d226bfabb8203c88038cb6dc1dde4e4c252841162d36eaec03"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1027/nuon_linux_amd64"
    sha256 "7cd2909a25c442407cdac4ed6867972966d1e6719391984ab5f9ba3c13519785"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1027/nuon_linux_arm"
    sha256 "3d72f891789d433f3dfb160ef7f593efa7f5a60f74dbf97e064f621b4e075977"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1027/nuon_linux_arm64"
    sha256 "44ae7f35bc546bb15bd80b098052ca137a9025cfc0cd0aaebe2911f5690daf95"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1027/nuon-lsp_darwin_amd64"
      sha256 "97900fbb9ed4a3135ffc91d6021a661795b84786a8ec56ade39d3be6341baa89"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1027/nuon-lsp_darwin_arm64"
      sha256 "ccf362b74990924087f3b2ab934571085088c8429e5615eab6bc836f0ab44a3a"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1027/nuon-lsp_linux_amd64"
      sha256 "07409ab0d441cf130af152664e7c0061005eeb37ba20bbd5a59e6ecfa7dc3355"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1027/nuon-lsp_linux_arm"
      sha256 "1d3bbfb236bca0cd47ae6429f8a26a07f1aaa2abf3a25c32ff5c3683d72a8a72"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1027/nuon-lsp_linux_arm64"
      sha256 "e677877ba868aab887b4351c1c6e4d5ba3f85aa6778bcab6a5a638b5afd79840"
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

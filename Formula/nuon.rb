class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.904"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.904/nuon_darwin_amd64"
    sha256 "0d447c0470a01a2b161e6adcc1160be5c2045e51bdbca4d7904f0621dc337650"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.904/nuon_darwin_arm64"
    sha256 "fb25a7ff1746c56eed389e2f5b14748c4effba223ab101d403907259e44b79aa"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.904/nuon_linux_amd64"
    sha256 "0ece92c7d514e4e15ac6c72d0ba63910ff9b6deff336fc5629f1d2a5a1c4b3ee"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.904/nuon_linux_arm"
    sha256 "5c83eb373ca15549ec8a07651d1392a450e1930a6dd03e1a6a7e8a9e0125945d"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.904/nuon_linux_arm64"
    sha256 "c8b45fe0352848d8eac177cad2ce68f7a01fbac2bb71e16f0a90c73e846d0ada"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.904/nuon-lsp_darwin_amd64"
      sha256 "61799a7faea6b0c2fef1bcc29c05d9b6f33762ade018b50a00d3bd90c6a95201"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.904/nuon-lsp_darwin_arm64"
      sha256 "6e36ab5ad49486a6f9323cfb5e5db17e1fa128a10085d6a950411c4f8229d65a"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.904/nuon-lsp_linux_amd64"
      sha256 "b0e421679981a012124b8e5e2173daabb8d98e6aec883d7350791832a83932ef"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.904/nuon-lsp_linux_arm"
      sha256 "f943ef2fed68482012c1659e72f52a0c695d3a22d029bc5946b76d986a17f859"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.904/nuon-lsp_linux_arm64"
      sha256 "b498344dc430f6df605a6c18619695dc90ed52027983bf3eab2d9adf16d7629f"
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

class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.907"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.907/nuon_darwin_amd64"
    sha256 "2b359d0a4d495f74ff2cce23be1d9649b7286057a2392e1340fe1e855423829d"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.907/nuon_darwin_arm64"
    sha256 "c924bf3891bb5f3232b3b0713db5df9ec247ddbf35aefbcad6bfbe9b7a663da4"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.907/nuon_linux_amd64"
    sha256 "7d85258ae1571cde179e8c89386e8f3cd1b3477e6b57a0f9afde4955bb218e96"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.907/nuon_linux_arm"
    sha256 "4c6a34feeb3e972245ce624bf9d9890040be38d15b5b63c502005b68506fae63"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.907/nuon_linux_arm64"
    sha256 "02f1ff7e1b517c584cd659d2062efc8c7ca4c4445935777e0949a14105bc261c"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.907/nuon-lsp_darwin_amd64"
      sha256 "61799a7faea6b0c2fef1bcc29c05d9b6f33762ade018b50a00d3bd90c6a95201"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.907/nuon-lsp_darwin_arm64"
      sha256 "6e36ab5ad49486a6f9323cfb5e5db17e1fa128a10085d6a950411c4f8229d65a"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.907/nuon-lsp_linux_amd64"
      sha256 "b0e421679981a012124b8e5e2173daabb8d98e6aec883d7350791832a83932ef"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.907/nuon-lsp_linux_arm"
      sha256 "f943ef2fed68482012c1659e72f52a0c695d3a22d029bc5946b76d986a17f859"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.907/nuon-lsp_linux_arm64"
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

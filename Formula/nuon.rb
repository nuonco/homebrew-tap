class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.906"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.906/nuon_darwin_amd64"
    sha256 "f9db259aafb5cb85f122d557d06e80e374beec067d3bc3f3ba1a67880078185c"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.906/nuon_darwin_arm64"
    sha256 "443803cebc797f47564d4003b92ef8dd69b0364920478de2718330db435c45c6"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.906/nuon_linux_amd64"
    sha256 "196ef72555dd89ea16dc48487be2a76b78c9ac259899e434ad7d9b42ab6d5b1d"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.906/nuon_linux_arm"
    sha256 "efe3defdd850d6fd8be5a9aeb911002db27e4f791d642bc4668d1880067c03c2"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.906/nuon_linux_arm64"
    sha256 "10f7f4c46f1835b822cd572559e5d521c160f56796bbf93700027788ca4b7398"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.906/nuon-lsp_darwin_amd64"
      sha256 "61799a7faea6b0c2fef1bcc29c05d9b6f33762ade018b50a00d3bd90c6a95201"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.906/nuon-lsp_darwin_arm64"
      sha256 "6e36ab5ad49486a6f9323cfb5e5db17e1fa128a10085d6a950411c4f8229d65a"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.906/nuon-lsp_linux_amd64"
      sha256 "b0e421679981a012124b8e5e2173daabb8d98e6aec883d7350791832a83932ef"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.906/nuon-lsp_linux_arm"
      sha256 "f943ef2fed68482012c1659e72f52a0c695d3a22d029bc5946b76d986a17f859"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.906/nuon-lsp_linux_arm64"
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

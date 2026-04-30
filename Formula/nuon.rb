class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.905"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.905/nuon_darwin_amd64"
    sha256 "7e3a0243310233cf2c8357f1cc19bd3511004935faaa2cc2587a213861b68725"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.905/nuon_darwin_arm64"
    sha256 "f573faad1625220ba4aa1dbf3e54cff4c19bb1972e091615ee205b00be6004ac"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.905/nuon_linux_amd64"
    sha256 "4f8f9483476b945f2466549ee0451d1ee19fb6fe32928d0ff8bb3011b3811a5f"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.905/nuon_linux_arm"
    sha256 "21c53f43835c13e63f52793905f9e05d921e3ec7ea24df445fb1a5b64491e1f5"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.905/nuon_linux_arm64"
    sha256 "1eb790394ada8ac8b2a4094299ef3975a79dc5c3929bc235623823fa139c86f3"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.905/nuon-lsp_darwin_amd64"
      sha256 "61799a7faea6b0c2fef1bcc29c05d9b6f33762ade018b50a00d3bd90c6a95201"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.905/nuon-lsp_darwin_arm64"
      sha256 "6e36ab5ad49486a6f9323cfb5e5db17e1fa128a10085d6a950411c4f8229d65a"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.905/nuon-lsp_linux_amd64"
      sha256 "b0e421679981a012124b8e5e2173daabb8d98e6aec883d7350791832a83932ef"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.905/nuon-lsp_linux_arm"
      sha256 "f943ef2fed68482012c1659e72f52a0c695d3a22d029bc5946b76d986a17f859"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.905/nuon-lsp_linux_arm64"
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

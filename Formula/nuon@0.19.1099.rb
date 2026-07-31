class NuonAT0191099 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1099"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1099/nuon_darwin_amd64"
    sha256 "e8743033c44f0b42527674ce174381f36e13dff51ea881ed549a022f587f7da3"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1099/nuon_darwin_arm64"
    sha256 "e0da755b2cce3998e03b49e5a85bc147f06855a1f3ae478cbe78ec7d8ffa6a64"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1099/nuon_linux_amd64"
    sha256 "e41a42924c977b5d80cacafbe0bb01a8990be690f19969a917ecc3bbb2351e07"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1099/nuon_linux_arm"
    sha256 "bec56c23a029af37cb3d8faea824fe719c758174b3394c73e355e03793a452c3"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1099/nuon_linux_arm64"
    sha256 "ba198f8ee563e88a17dbf1c8c90d46831777071b12c6ba2a566f2b2b7acb5339"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1099/nuon-lsp_darwin_amd64"
      sha256 "a761d0360d26b8857e0441059c3eb784f920648be333072e5ff01ca4a91d8ecc"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1099/nuon-lsp_darwin_arm64"
      sha256 "6445179001b9dfdf5c582a98362e7793b1e4b1f87ba4448f800b70991fab58bf"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1099/nuon-lsp_linux_amd64"
      sha256 "0584806908b2176a99062efea34199352e4d4628b9540be232776f9d012f2a20"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1099/nuon-lsp_linux_arm"
      sha256 "8dbaea34a612e3ca336481ae2bedeeeb8d55001943a5bf7fde6e95a8e73ed23c"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1099/nuon-lsp_linux_arm64"
      sha256 "c7b2b80939d10531129519c597f331d7c04d21cadf36767f9b7e922b86610f73"
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

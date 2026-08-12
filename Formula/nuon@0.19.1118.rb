class NuonAT0191118 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1118"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1118/nuon_darwin_amd64"
    sha256 "8496314ecb06e106e768ba73abaed76836c74dea456c2312524cb40a34006dd9"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1118/nuon_darwin_arm64"
    sha256 "ec09373c0d9edc7fb9823a4b8b0824c9c9648ab4b55c34a62e82bc521d1fe4f2"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1118/nuon_linux_amd64"
    sha256 "55054b2fe909867700c5920d1f6547475e2f972f22b9797f5bdf386f2ee8b74e"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1118/nuon_linux_arm"
    sha256 "c9dcd8be5b84707524961bf5ff00a0cd48e7e6d69ba347178d301724de0d9ae1"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1118/nuon_linux_arm64"
    sha256 "7239f422bc6befac2f68ae51124df0f2bb2c3116b083f1a59b91b17c958b9d7c"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1118/nuon-lsp_darwin_amd64"
      sha256 "1991bf14e3e4006be3c409da934d2d6da53ff3937f5e367b416eaf7b82bec9fb"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1118/nuon-lsp_darwin_arm64"
      sha256 "408b13ce8b78ea5008fbcf99febe6f1c2738403e2947fd582d66d11cbd756b2f"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1118/nuon-lsp_linux_amd64"
      sha256 "3d72767c8f09001fbc9f7667f9e5b1378eae609d12695c77672e54b24491ca2b"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1118/nuon-lsp_linux_arm"
      sha256 "8a8d951b794250a3949338093ca64f9de2cd874c59ad0d990874cbdd90fbf90c"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1118/nuon-lsp_linux_arm64"
      sha256 "d88bed0d024830ebde217ab0f51b5253cfcd7a8b49af8f9c3131d5d6d572ae57"
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

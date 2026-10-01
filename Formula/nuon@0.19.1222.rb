class NuonAT0191222 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1222"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1222/nuon_darwin_amd64"
    sha256 "8c3cf901b54f60ff08f62978f97954c9c0d83f6428ca58f17ba26a79ba60ea7f"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1222/nuon_darwin_arm64"
    sha256 "dea4175fb969cfe7ad0ab0ea27d00dee5cc58c18bc88ebeb9d1064f8833138da"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1222/nuon_linux_amd64"
    sha256 "1da49344fde1f577f10781f48d079359a7d3442d5a99964592ed3eee34d199b6"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1222/nuon_linux_arm"
    sha256 "9fbe0aac4c5b64fcab85aba7e5172886a1dc63fa43137cc3c220351810bfc40f"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1222/nuon_linux_arm64"
    sha256 "8d96b37ec50b46220d766e311cca46d841c4ce1f4adfe3db89d6a72f389989c3"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1222/nuon-lsp_darwin_amd64"
      sha256 "4a10c63302f7e76cf5fd0d9c5c8456e49ea73c6f8e5262ee3897bbb41461c690"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1222/nuon-lsp_darwin_arm64"
      sha256 "57f0f277db8d7e23635028611692cafc5a9333673a43259ca1e8ef34229a8039"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1222/nuon-lsp_linux_amd64"
      sha256 "0163f1578972b9b3f8a769738e1030e52506743b723c1b2f16084901ae023bcb"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1222/nuon-lsp_linux_arm"
      sha256 "678fba94072c44d286fab2868c81f1e4c33c277e648fb147aeea8f9a2b146d92"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1222/nuon-lsp_linux_arm64"
      sha256 "d213769d90fb44c2c702ba465d4ab2ccf43af7dceb953786972209044be6f245"
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

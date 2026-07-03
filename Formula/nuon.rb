class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1037"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1037/nuon_darwin_amd64"
    sha256 "153bc6a063d6d8498d60b1a0364a04d5ccb2ac0e0b5cb38a3e5b10d9b8edc674"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1037/nuon_darwin_arm64"
    sha256 "3470d3f8af2717722bd118e312cfdb89b1fab5e1e1b5933a23167457078e3b53"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1037/nuon_linux_amd64"
    sha256 "e233b854241dc4719991834aefd9ef1e54ad4a06942a39a1e0ec065b8f7a571c"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1037/nuon_linux_arm"
    sha256 "c0d38cc5defff9e807dedd85f756862a3ca018bdc28ac55a956de818ea2ca42f"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1037/nuon_linux_arm64"
    sha256 "422b01e55414502a0feebe1b028102725b493435dbd38f9346289125ce79579d"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1037/nuon-lsp_darwin_amd64"
      sha256 "ca3577fe5cb1d5846cfa3c5152fc9d15c7b83edc68d3efdf26a679e148288f2f"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1037/nuon-lsp_darwin_arm64"
      sha256 "5b12723c0ff04024f1ec855313ba9fe35c32113f15113ac4ecf045596d02b185"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1037/nuon-lsp_linux_amd64"
      sha256 "d099c2561b658b24b51f1c09318bf72e9344904fe59b77f38d1590d4cf4e85e5"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1037/nuon-lsp_linux_arm"
      sha256 "533fb1ad5c0c3ae012998da02d725a957098351d7e190325664485a995dae50d"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1037/nuon-lsp_linux_arm64"
      sha256 "68f68351bbc67bfa731e4494c55919ed58ec7b1beac2c6ae2c1ed212ca4c94d0"
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

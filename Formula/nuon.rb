class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1034"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1034/nuon_darwin_amd64"
    sha256 "ecec55e15a3a7e1c3a3725a30f749629a6662783b80ac1b5daf07a1e0bf732a6"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1034/nuon_darwin_arm64"
    sha256 "312475c731041a09545b82c776732d70c183eef6d25355c6121d27a9247b17df"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1034/nuon_linux_amd64"
    sha256 "657591979a1aec9520abc7544bb7c4231e9cd023ec502d82de33abd4dd50e9f5"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1034/nuon_linux_arm"
    sha256 "ec0b2b028bbe6a43afeda75f73c924877bcc26fde9cdcaf0a9732f426ede9a69"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1034/nuon_linux_arm64"
    sha256 "6efc1103baf76504d5f75ef5d4db9ee3354a46a0f502f4db5f51e78ebbb4fe26"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1034/nuon-lsp_darwin_amd64"
      sha256 "ca3577fe5cb1d5846cfa3c5152fc9d15c7b83edc68d3efdf26a679e148288f2f"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1034/nuon-lsp_darwin_arm64"
      sha256 "5b12723c0ff04024f1ec855313ba9fe35c32113f15113ac4ecf045596d02b185"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1034/nuon-lsp_linux_amd64"
      sha256 "d099c2561b658b24b51f1c09318bf72e9344904fe59b77f38d1590d4cf4e85e5"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1034/nuon-lsp_linux_arm"
      sha256 "533fb1ad5c0c3ae012998da02d725a957098351d7e190325664485a995dae50d"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1034/nuon-lsp_linux_arm64"
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

class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1029"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1029/nuon_darwin_amd64"
    sha256 "98df53a1256f635adef1e7bd06659448233f0863d2a8e566f8ccb60aa6fafdf4"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1029/nuon_darwin_arm64"
    sha256 "2a2c5510a9a6b56db068062a78adf520896e4e0b0ea1457a155e18a23e4a69e4"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1029/nuon_linux_amd64"
    sha256 "282047544112a17e93fce7de59465fa178cddc79757f0e5dbecf977de39896cb"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1029/nuon_linux_arm"
    sha256 "827843d23ddf22886d90f6189b50d1b588ddb3d779aed0914d3a36bfac780bf3"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1029/nuon_linux_arm64"
    sha256 "2ce2a6a00f1ef6e7459921833993b78d11f9ab2adde343873f47cd577a68d50d"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1029/nuon-lsp_darwin_amd64"
      sha256 "ca3577fe5cb1d5846cfa3c5152fc9d15c7b83edc68d3efdf26a679e148288f2f"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1029/nuon-lsp_darwin_arm64"
      sha256 "5b12723c0ff04024f1ec855313ba9fe35c32113f15113ac4ecf045596d02b185"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1029/nuon-lsp_linux_amd64"
      sha256 "d099c2561b658b24b51f1c09318bf72e9344904fe59b77f38d1590d4cf4e85e5"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1029/nuon-lsp_linux_arm"
      sha256 "533fb1ad5c0c3ae012998da02d725a957098351d7e190325664485a995dae50d"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1029/nuon-lsp_linux_arm64"
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

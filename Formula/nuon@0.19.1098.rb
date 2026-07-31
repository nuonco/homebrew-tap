class NuonAT0191098 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1098"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1098/nuon_darwin_amd64"
    sha256 "4c329808d33a230ba58fa14aed6540a11e01a830be7e64fe0793cfc85fe1ca10"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1098/nuon_darwin_arm64"
    sha256 "8b72c306c4520dba96d83398608ff8fbba4bc5b702a0d7369d8cb22b8df34d61"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1098/nuon_linux_amd64"
    sha256 "65ba8a9e3961ff4efae04c6ef8b00f578659f60eba40cb044aad7d7b223ac5f5"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1098/nuon_linux_arm"
    sha256 "0b33a591d24ee242df4dfd02040c4bc4c84c50b215d5e69fcf4a0ac1221b9064"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1098/nuon_linux_arm64"
    sha256 "cc8b7e595e1c245da59d2ab23437f6f0dd7b48ee68ddd4ec25216635070eca4f"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1098/nuon-lsp_darwin_amd64"
      sha256 "397f904504e2dd09b08dc3d209d1e20b47bd13416eec2ab204f52549b742899c"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1098/nuon-lsp_darwin_arm64"
      sha256 "5e0e81fab9970d0f27128ae7c438abf70ac108c56d1cc1112e1b9db1d2314912"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1098/nuon-lsp_linux_amd64"
      sha256 "8b3c2c0b2affb28b6761598d125f2332ce9e50192504084246be73c427f4dea3"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1098/nuon-lsp_linux_arm"
      sha256 "4e595e557583f45cf7794f1354446914360d2cdfd0810a0f038ad7f3f07864a1"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1098/nuon-lsp_linux_arm64"
      sha256 "c5857803ca3fcd78544afb4d441008393bb7777dfa72c44ffe064a907bb44aa0"
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

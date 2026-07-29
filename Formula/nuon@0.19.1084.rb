class NuonAT0191084 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1084"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1084/nuon_darwin_amd64"
    sha256 "3f1908022943ad9eaac87d50a7769325e036b558fade8476fed4aff3c0011c14"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1084/nuon_darwin_arm64"
    sha256 "56c0b785cc3c6adbe2888bf51231742bbbba7adead0a88335deb1ae6d45d8f78"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1084/nuon_linux_amd64"
    sha256 "84a07dda0de97114068728e80be238855eb4566fb4af1bc76d914e54397904db"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1084/nuon_linux_arm"
    sha256 "91a48b1152415c62d29f610151424872a07744f844a14472c0b40a656d841561"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1084/nuon_linux_arm64"
    sha256 "9f0bd33cb120a9beb842190bc26e24db666a87d84853dea08e9ed70657437848"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1084/nuon-lsp_darwin_amd64"
      sha256 "eb6f293f0b5742b0ef5a16295b0bf452b238626284a87b20885fa336cd53d106"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1084/nuon-lsp_darwin_arm64"
      sha256 "b91a43a02e4579fd71dc025f1757dc2a9a23fd07054fd0097f1eaa087b27c3e6"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1084/nuon-lsp_linux_amd64"
      sha256 "76adb2d082c6eac46733bd9b8aacb21fdb3a3a71e33f52ba0d8d515d6df4fd09"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1084/nuon-lsp_linux_arm"
      sha256 "26cbd55cdc1d925f034e3eeb5c839a84c354e5536672018f22285e9b6979f65e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1084/nuon-lsp_linux_arm64"
      sha256 "4f077103ec674535186f5f016b88fc5ca0e7b7ce3afc11ba27d47a33b27ba662"
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

class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.994"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.994/nuon_darwin_amd64"
    sha256 "c90570da5ef6aa64798ada5a6afcf9b93107aadf4637ea51bfa54c4ec36b608e"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.994/nuon_darwin_arm64"
    sha256 "08114b76250e51ce60ab9ad41634b0db9f657be267790cb09eebd2341ec1d54e"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.994/nuon_linux_amd64"
    sha256 "a92cdaf41387083b9b62ce089f3af6c7eb275497cdad0e66fd3dfbffc16af0d3"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.994/nuon_linux_arm"
    sha256 "675bfa29ac209f8d303571fb75d2ca6c705f3e856755681b40e918a0f74eaabe"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.994/nuon_linux_arm64"
    sha256 "49dc54d0033821197efceafcf0dfed0557b1404863befae20e78c09353de907e"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.994/nuon-lsp_darwin_amd64"
      sha256 "1fcb915e96a7738eaa537dc3682337661e24d79202900056fd58455dd1c92c19"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.994/nuon-lsp_darwin_arm64"
      sha256 "4037d26e21a9be8509948f213fea258349ef3f097da4a7a34b399195ecc132c4"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.994/nuon-lsp_linux_amd64"
      sha256 "5691d043f3f0d74faf882244387f8eb0d38df81f4591f55a07228e3da6605f3a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.994/nuon-lsp_linux_arm"
      sha256 "45ad065401cc0ec094bc35c7a1a29065850ca6d7a575983b2d23739bfbd4fcd7"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.994/nuon-lsp_linux_arm64"
      sha256 "4f0d7a57c91634cb44db6f7ed88ea1d37776da37484f693dcc15b80530ba879d"
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

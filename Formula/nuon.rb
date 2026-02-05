class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.767"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.767/nuon_darwin_amd64"
    sha256 "5d929c2bfff7f8fdd47d26c124ed4498c653c57b71c1f341113e4e65a2dd8411"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.767/nuon_darwin_arm64"
    sha256 "df22f2e7fbe9b38fb4a86fe5d83474c368f31b180c10ca9aeaf7f759253e6115"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.767/nuon_linux_amd64"
    sha256 "ece13f05c789ad3b619cdc69f9f9218a2d24da9dfee321537702f31fc064c93b"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.767/nuon_linux_arm"
    sha256 "0c29823c88d6ca1b5371c9ff5daeb597f132217fe641383733b65db3457b3d49"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.767/nuon_linux_arm64"
    sha256 "d921b478923d97e0be9b5587f4858e40050a2979a6017446ae98a9c46973d747"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.767/nuon-lsp_darwin_amd64"
      sha256 "a95bbbaf1cec5cb2efb8e2eb357ccc88bfce2169c7192081bec133338080d1d2"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.767/nuon-lsp_darwin_arm64"
      sha256 "7b777d1bc8475aa493ff7a8789750ac21a481df46e81b4e7e9f2f0e1b74b4db3"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.767/nuon-lsp_linux_amd64"
      sha256 "ef129edfc912eed1527bfaae673d268cdba3f3d11422bd2388d8013fdccd149c"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.767/nuon-lsp_linux_arm"
      sha256 "9a89fa67f9105f9b92d6404c3f29c698d255f71c55c67d0a80876a2b542c3fbf"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.767/nuon-lsp_linux_arm64"
      sha256 "eb5609e36a6f9ac916d37628b1b92ff0daf74b768df1cdbaf860b7e9780930cb"
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

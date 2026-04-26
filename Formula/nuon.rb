class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.896"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.896/nuon_darwin_amd64"
    sha256 "28162e6a7a9c2ce914d8a87cd3dd72c75fcefc690fefbccf42fa82a403063fad"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.896/nuon_darwin_arm64"
    sha256 "a237b01020f16e74dc89e85725a5811edbfd7f6c42887153a5eb27ebcfa97279"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.896/nuon_linux_amd64"
    sha256 "ba631f5ab8871b761f465e407edf770e1f189ee5176d844a5a5d4d7303b8a8fe"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.896/nuon_linux_arm"
    sha256 "2f3b95943ce5b78ca5b4904afc5ac1850ced082cb58ab7cd24044740e4fdd436"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.896/nuon_linux_arm64"
    sha256 "d761a1d9c1b3c9a4c5d97e23f4963af455f45ad68a1c293592ab10a6384d1d65"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.896/nuon-lsp_darwin_amd64"
      sha256 "8f6ce11dd3367a23f84e7a97aa01fda85c08320421ff00c74c79e683164e95ff"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.896/nuon-lsp_darwin_arm64"
      sha256 "c4192626ce58d71732913cc7b58d31b821d082e7b6dd4daeb6bfc9ed8e37b885"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.896/nuon-lsp_linux_amd64"
      sha256 "dc594627321d379ece820932a111f971d03ebf1985db1f5f0ed8146896e215a4"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.896/nuon-lsp_linux_arm"
      sha256 "7ca8657ccfba8a1aa05876fd48d455343c1083597a53589020044729f613709b"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.896/nuon-lsp_linux_arm64"
      sha256 "884d2a8385a054e56f28ae202a22e81f2a65675b8fc37421635e3f717c7492fb"
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

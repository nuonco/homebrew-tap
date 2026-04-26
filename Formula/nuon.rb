class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.894"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.894/nuon_darwin_amd64"
    sha256 "394b12eabcf01ab94703382a35da9ad5bfc7990c6158e26f3693b75aa139df16"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.894/nuon_darwin_arm64"
    sha256 "4dca4744edc4554146495a5e93fc2017e88f7e0991abdd17aaa5d853858fcbf1"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.894/nuon_linux_amd64"
    sha256 "92bd57a5074c0efe7f756cef2084316cfc357db084a71f02f3e1ad3e122f9367"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.894/nuon_linux_arm"
    sha256 "41016df69f11d53248ac719d6a6b747825308f49b330459024d4df3e379b5ce3"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.894/nuon_linux_arm64"
    sha256 "b685af9db25ce0eea4429169ed032b864533e8b55377feecf9438de532941a02"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.894/nuon-lsp_darwin_amd64"
      sha256 "8f6ce11dd3367a23f84e7a97aa01fda85c08320421ff00c74c79e683164e95ff"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.894/nuon-lsp_darwin_arm64"
      sha256 "c4192626ce58d71732913cc7b58d31b821d082e7b6dd4daeb6bfc9ed8e37b885"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.894/nuon-lsp_linux_amd64"
      sha256 "dc594627321d379ece820932a111f971d03ebf1985db1f5f0ed8146896e215a4"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.894/nuon-lsp_linux_arm"
      sha256 "7ca8657ccfba8a1aa05876fd48d455343c1083597a53589020044729f613709b"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.894/nuon-lsp_linux_arm64"
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

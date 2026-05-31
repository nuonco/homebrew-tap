class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.985"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.985/nuon_darwin_amd64"
    sha256 "4b14976f35d0833098c2279688db1fd5e81f85acf5344464e429752586d51c40"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.985/nuon_darwin_arm64"
    sha256 "68e81e17fba472b860b8896c4776d0a8d746e4c6e046bbbad7eb65b803ca861f"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.985/nuon_linux_amd64"
    sha256 "4705dc0b4cc1b676d422cc20765ea658b6286f56b025c41d7c5a4a10dcc054b6"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.985/nuon_linux_arm"
    sha256 "c2919d2f15c1327ab380f38d401636b58190822ed939618fb414affc0385cd23"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.985/nuon_linux_arm64"
    sha256 "660dc904ca17a370d3bae0271ffdfa3ef52edeb71659aae36935b95fd9ceb017"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.985/nuon-lsp_darwin_amd64"
      sha256 "587f8b0139e4c77856c7680419f56edffa278b877a310f96158fd2a88acd1dad"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.985/nuon-lsp_darwin_arm64"
      sha256 "c474c8d5c8470608b1de96a653989b808b06eb20cc8648decb508a372555e288"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.985/nuon-lsp_linux_amd64"
      sha256 "5af55971642caa29a957d1f7147632c6f08d59c41aaabbb2d52a1ee4ce2fb042"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.985/nuon-lsp_linux_arm"
      sha256 "8f8a87ef08ce498c079e70d5c89def3dc2b14d501380a8fdefefc59f76ee3d64"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.985/nuon-lsp_linux_arm64"
      sha256 "2bdbb4ed7f827c80cdb30f45f6bf054c77dc2b0a0c9ed52eb5ccdfb7341b6b73"
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

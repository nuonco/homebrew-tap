class NuonAT0191160 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1160"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1160/nuon_darwin_amd64"
    sha256 "be43179fc9c160d7b99b10e708b90233576b1cf4788b2d40941336273c49594b"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1160/nuon_darwin_arm64"
    sha256 "fa06f7fda7a0d74f4bd89a4a0d46a8da90c7cfb98902efcb7f219551ccc593b2"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1160/nuon_linux_amd64"
    sha256 "a9f5555ae032e92b0e368a2a223df91034bfd851096a2abb5e915f56a0dc53ba"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1160/nuon_linux_arm"
    sha256 "d9dfb89e38b0ede366cc7062e370004156ea24a182b7512e16e6982d4746ca70"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1160/nuon_linux_arm64"
    sha256 "2fe542c03167c7a1298113f78fbf9a66287a981bdab894cf5cd0873f399e0f2e"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1160/nuon-lsp_darwin_amd64"
      sha256 "14c7682f4ffc5edc9f5ed42251b8963bfbeda9e2c7563137aaf205c2de18724b"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1160/nuon-lsp_darwin_arm64"
      sha256 "dc88f853179d53cc0b125196ce7d6dfda8ac249e0ba6bdafa7801f4e6071b7c9"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1160/nuon-lsp_linux_amd64"
      sha256 "4b761883f3cec39da1d4373663ee03aa08d4a5c11615b5341cffc69d430f5bb4"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1160/nuon-lsp_linux_arm"
      sha256 "dfe9359293a17c9cebd078118d1d96b61f5594eaf55cbad2d1c909456ac2e5c8"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1160/nuon-lsp_linux_arm64"
      sha256 "fa14fb9dda0d3ef46eafb326d0d692ba1ed2bed69fa641a57c45d74fb98c1ebf"
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

class NuonAT0191107 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1107"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1107/nuon_darwin_amd64"
    sha256 "c430c0d93d713b508ce0a8e68af6e0520ef38d173870f9bc926eabbb4034137e"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1107/nuon_darwin_arm64"
    sha256 "38f3b32ffbe1b71a88a9f06eecfa817d072794c70fd81493a3da96de2e0673db"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1107/nuon_linux_amd64"
    sha256 "86726787e0d37dd7571aa54301ef93d23d7db9c7a20a3dd3857fdd6851f099fd"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1107/nuon_linux_arm"
    sha256 "fcfae9330401323047d0992cdb81a2bbd80ab30b0a16b7b8b75e89155b23d1a7"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1107/nuon_linux_arm64"
    sha256 "6c89dffd0eb294c987ace562abb0825926436e978a61bcce647345ae63956721"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1107/nuon-lsp_darwin_amd64"
      sha256 "71104a69c118406863425f333660c18838d4a8c427eb0611b8bb85f6221116de"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1107/nuon-lsp_darwin_arm64"
      sha256 "bba229c131d8840aac7efcb7eac5126b73bac08d909547285456aa4bbec983c0"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1107/nuon-lsp_linux_amd64"
      sha256 "669dda011e3609491b632e6e19f0fa9812d3ab9964dafbcef5c34906c711662b"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1107/nuon-lsp_linux_arm"
      sha256 "09d1c91b4947216ef0f3e7400b710d53b042d41cd489ec1f6da89f9272d7df04"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1107/nuon-lsp_linux_arm64"
      sha256 "0488e4664dbdff144a767abe0d70bb93e41cc1cc8cd61e810ad8c047a6263c9b"
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

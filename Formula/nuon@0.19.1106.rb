class NuonAT0191106 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1106"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1106/nuon_darwin_amd64"
    sha256 "05cc018d130c4ba16136959f2743425cff71f5550f65db7ea047672fee7def9e"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1106/nuon_darwin_arm64"
    sha256 "953a59b20f3966079e2f6cd4dec79b30b49c6e17fd1570f4456b92ea1fc56c23"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1106/nuon_linux_amd64"
    sha256 "98d590c7cf41673d08b7d792c5de879679b0eba1343ce556c0d5fdc75de84c30"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1106/nuon_linux_arm"
    sha256 "67e6b56441a8b8d9f5e5877d7d665b357be10b06b31fc0f367da5b27dc1b78ee"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1106/nuon_linux_arm64"
    sha256 "5885b5b25396912a2fa584beb55935e7b2f962113d96462440f8cd54cc29b9a0"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1106/nuon-lsp_darwin_amd64"
      sha256 "71104a69c118406863425f333660c18838d4a8c427eb0611b8bb85f6221116de"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1106/nuon-lsp_darwin_arm64"
      sha256 "bba229c131d8840aac7efcb7eac5126b73bac08d909547285456aa4bbec983c0"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1106/nuon-lsp_linux_amd64"
      sha256 "669dda011e3609491b632e6e19f0fa9812d3ab9964dafbcef5c34906c711662b"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1106/nuon-lsp_linux_arm"
      sha256 "09d1c91b4947216ef0f3e7400b710d53b042d41cd489ec1f6da89f9272d7df04"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1106/nuon-lsp_linux_arm64"
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

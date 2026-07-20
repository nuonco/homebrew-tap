class NuonAT0191072 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1072"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1072/nuon_darwin_amd64"
    sha256 "d284ac2cef88d3f9a3b037570b94f4b9cd34ac5c56ae69fd6e5804e437b077b9"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1072/nuon_darwin_arm64"
    sha256 "ccc044180f39b0854f5442099db9846ca0eb06cfdd7c6029d6a9115465e1a191"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1072/nuon_linux_amd64"
    sha256 "7fa63a69301e5e5afc6431fd9eba7e9199b5330bacc5747a67fc215197020721"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1072/nuon_linux_arm"
    sha256 "f75fdb481da3976fbfc719e57d7feedbf8d53fdc67ad2c6a505315f1dbb0376b"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1072/nuon_linux_arm64"
    sha256 "4a06133a729871f491554c6b78429672e5a56d77883e0f661ed820c30b29bd39"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1072/nuon-lsp_darwin_amd64"
      sha256 "998c6e0b3acf7494c9eb86cdcb554532696fdf8c437c622362f25b2b96def69b"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1072/nuon-lsp_darwin_arm64"
      sha256 "8d1945f731ce94f49c1e75c21e1a80d4950ee75874a0ce4114926304a4bbaa63"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1072/nuon-lsp_linux_amd64"
      sha256 "835aa5fde8f4ca11074eb7c805d922019be98dcdb9da4ca9a46cbea40086440c"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1072/nuon-lsp_linux_arm"
      sha256 "80af4fc8ebf4fb0eb566303baceeda45a69a16f95d25312ae5064ae058ceb874"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1072/nuon-lsp_linux_arm64"
      sha256 "6fd2d7058cc11a0a0ba2c4c1a6d0958265ebb56f1ff6ea2a997429f32c875d81"
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

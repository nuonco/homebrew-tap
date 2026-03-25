class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.854"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.854/nuon_darwin_amd64"
    sha256 "497ce07bde11550b90554276a82bfda2b09130c6de178c07ed38d590fc785df9"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.854/nuon_darwin_arm64"
    sha256 "4dbc84bb564cfe191693b0acd152b73dd9c684c09ad14436ec5e78029b1d5094"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.854/nuon_linux_amd64"
    sha256 "723ef38a227e2f23ccb8a7aef1f299223506cc0926ec1ea2337beb9d4bd387b2"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.854/nuon_linux_arm"
    sha256 "6ecb1aa799eb689b062e6475b4cb7d2f80aebbe8098f7aeec3f6aa3d13f7e491"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.854/nuon_linux_arm64"
    sha256 "954281e7846173b7736b49d17d7836ff48a24abf33673661ecd89b955df60209"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.854/nuon-lsp_darwin_amd64"
      sha256 "6389b2699beb8a395fc874dcd122e8573f75382fbf7c78a02ddbe73001430784"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.854/nuon-lsp_darwin_arm64"
      sha256 "241fdc6de5da74c6f987e0fb13168481cc6d1c4ac4d3f0ac9f9b278e0e7bb7e0"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.854/nuon-lsp_linux_amd64"
      sha256 "112c2138193f5f10b10e8e17d253824e02822d5c842884ed9d7432bbe700a3bf"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.854/nuon-lsp_linux_arm"
      sha256 "e377e76e1e855929cbb8b4d9335a863e18782be78cbed9324221571a9ef681ba"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.854/nuon-lsp_linux_arm64"
      sha256 "0df5d377d16f4b6343f9cd6bbaba731d0c6713fc7ca0fead38e1bb6e195040e9"
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

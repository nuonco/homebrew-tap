class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1279"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1279/nuon_darwin_amd64"
    sha256 "4a46aafbe549a3dcd8c4b3e37a8205a8ca64dda5bc63aaf27c7b5389b3b0c43c"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1279/nuon_darwin_arm64"
    sha256 "f579d00c5e73ac5644102157d45b40cc16ced1e2537cffca06ef61b27780426f"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1279/nuon_linux_amd64"
    sha256 "291c38e955e1b328ff8840632386b655a66b68744c55081a62e35e2592289a5f"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1279/nuon_linux_arm"
    sha256 "42c5e823ef59e9ce61451145955327f0ec9817154d4d827f3f58002687047004"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1279/nuon_linux_arm64"
    sha256 "89946f15afb9de4d80c212548adf7c7232965a2dc60a60479ce6288012a37f86"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1279/nuon-lsp_darwin_amd64"
      sha256 "6e7dee891c5f3941c127f3acd021e3e007df92d961af1939639c819ac4fbae45"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1279/nuon-lsp_darwin_arm64"
      sha256 "d2558ed91f6cf56c9e44e73cec5391ccf8ae650cae4dd79c581d24cd4927f273"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1279/nuon-lsp_linux_amd64"
      sha256 "6ce8e7c5c6792abbb170d4ab53a92c9a4b24178b53e60c53836ba2a551c4fe66"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1279/nuon-lsp_linux_arm"
      sha256 "80e518b499dcbe7996a520daf45cc479c905c1df911721f73d12f64cc0c8470d"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1279/nuon-lsp_linux_arm64"
      sha256 "5c8586030159c10b7b4c3efd7d7b4ee47460b0bb31d806111cf40726777b721a"
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

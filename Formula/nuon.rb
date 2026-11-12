class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1289"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1289/nuon_darwin_amd64"
    sha256 "1bdd8f255951148660ca9beba7c5386cf0ecb207aab175faa317536687947dcd"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1289/nuon_darwin_arm64"
    sha256 "cbd6fc5028dc82465ff072f6be924cd33cb77d6c155280d174090d06ca291ef9"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1289/nuon_linux_amd64"
    sha256 "27b5deef2441ef22ec8866e40871e96e007262dc003def11491329e5d133e181"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1289/nuon_linux_arm"
    sha256 "05c176532b9719696d844939a1d7eeb52604e3f6bf46f491acffb4d072af20ba"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1289/nuon_linux_arm64"
    sha256 "d589ec77d2a3a358b52032473f2a5b799280820f4467c28f27780e4c8b884a14"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1289/nuon-lsp_darwin_amd64"
      sha256 "0d1e874a469225c72859a36b0dfa97888ea48f7d574370c95c1128ecb48e734a"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1289/nuon-lsp_darwin_arm64"
      sha256 "4a4a797bd9887bda52c5d256215c7ecbc5e6cf94d2231cf0075a0743f05b6ff6"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1289/nuon-lsp_linux_amd64"
      sha256 "6f1ec1ea8b89d9a55d05fee9a2127f937728101f417ed3d3be722d8a4afe0919"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1289/nuon-lsp_linux_arm"
      sha256 "595b95e72beb258f6bec33be3744da44f125fdcac58bfda852f1ec16fd4cf4fe"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1289/nuon-lsp_linux_arm64"
      sha256 "762d57dd0716c2df637acd44dd157d627ab2623c8f4fab3d4ec751164e213ab7"
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

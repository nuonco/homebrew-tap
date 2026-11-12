class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1290"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1290/nuon_darwin_amd64"
    sha256 "c40529821ddfe3c4d2a0ef87a070b8fb1a603a7be5a1cc71fa3d3e2f8433a765"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1290/nuon_darwin_arm64"
    sha256 "a0afb3004018a59b5e83d90b55eb4d1e2699be8bbebeb1ce6b6bf7259d1e6e9f"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1290/nuon_linux_amd64"
    sha256 "6629e7d9efb078ae0b66b74c02d298a3cd10d37207a01cc45e41bbe1a712260b"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1290/nuon_linux_arm"
    sha256 "35f9bcac2081c74d231e90d663ff63910db0f36057b2678e3c4963c5c8ab5fc3"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1290/nuon_linux_arm64"
    sha256 "71acf6ae220099aed4212e974ddf80fa74a13eaaf13c8fe5f2a6b1f431710359"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1290/nuon-lsp_darwin_amd64"
      sha256 "0d1e874a469225c72859a36b0dfa97888ea48f7d574370c95c1128ecb48e734a"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1290/nuon-lsp_darwin_arm64"
      sha256 "4a4a797bd9887bda52c5d256215c7ecbc5e6cf94d2231cf0075a0743f05b6ff6"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1290/nuon-lsp_linux_amd64"
      sha256 "6f1ec1ea8b89d9a55d05fee9a2127f937728101f417ed3d3be722d8a4afe0919"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1290/nuon-lsp_linux_arm"
      sha256 "595b95e72beb258f6bec33be3744da44f125fdcac58bfda852f1ec16fd4cf4fe"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1290/nuon-lsp_linux_arm64"
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

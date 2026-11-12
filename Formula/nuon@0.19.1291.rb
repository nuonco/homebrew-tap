class NuonAT0191291 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1291"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1291/nuon_darwin_amd64"
    sha256 "f426acda806cf8f37a988caf74777ecd49d3cf3bf01869decfc64cc73b162290"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1291/nuon_darwin_arm64"
    sha256 "a9a46351202c69011f2e5030e25f0fe372f99e8dc371e316050d5148ecaf7636"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1291/nuon_linux_amd64"
    sha256 "f464b8f06198c33e00bf1d9e350a016ba52915ed59c76f861f144294aaa49697"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1291/nuon_linux_arm"
    sha256 "ffe316ea3d82c1dde248de68b8d409a82e2865c0465af8322c33cd6175d59859"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1291/nuon_linux_arm64"
    sha256 "43bd7ef8835f795e78a9f1cb25e77223f2c7f513fd0da7f3434b69e7e1e298bb"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1291/nuon-lsp_darwin_amd64"
      sha256 "0d1e874a469225c72859a36b0dfa97888ea48f7d574370c95c1128ecb48e734a"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1291/nuon-lsp_darwin_arm64"
      sha256 "4a4a797bd9887bda52c5d256215c7ecbc5e6cf94d2231cf0075a0743f05b6ff6"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1291/nuon-lsp_linux_amd64"
      sha256 "6f1ec1ea8b89d9a55d05fee9a2127f937728101f417ed3d3be722d8a4afe0919"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1291/nuon-lsp_linux_arm"
      sha256 "595b95e72beb258f6bec33be3744da44f125fdcac58bfda852f1ec16fd4cf4fe"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1291/nuon-lsp_linux_arm64"
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

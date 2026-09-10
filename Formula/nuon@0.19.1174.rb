class NuonAT0191174 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1174"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1174/nuon_darwin_amd64"
    sha256 "d1d4fa12321873eb03e14c8ee4c41137f5b289689ffe448eaf106896daa6c3ba"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1174/nuon_darwin_arm64"
    sha256 "a365f171be3c574ebd5b55a5d190f0cc60ba2dffd8bf38c8402787e6353f7a15"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1174/nuon_linux_amd64"
    sha256 "93cf5916f36d064ee16596cb5b1b122f5dfe8a1f0b6786a684b219fb8d1b0c77"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1174/nuon_linux_arm"
    sha256 "a2bbf04a516fdc6e034dda386e30ad3c8d52484b9c3a459f32ec9151aa52342b"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1174/nuon_linux_arm64"
    sha256 "e0e21dfe320a2786266067f9c5956e45888a33f7267a75773fea8a8ac180bc0f"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1174/nuon-lsp_darwin_amd64"
      sha256 "b537506e38ddec4af0b4467396c28cff461a08d01ed441cd8efa0c78f44bf73f"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1174/nuon-lsp_darwin_arm64"
      sha256 "96d29019af0ec34a0beed49553e0a7d286357c943a06b9e4cf5d97f4592deeee"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1174/nuon-lsp_linux_amd64"
      sha256 "f6fbb0a87110bbad03de776e7fdf1f81eb111662f99b5555d4fe00fab6ad0947"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1174/nuon-lsp_linux_arm"
      sha256 "6dcf7f3db9e244d9885a32564896a4f9c5a5f9844101fd57a96b37169c9c361f"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1174/nuon-lsp_linux_arm64"
      sha256 "cfb1642c41d43eb8f753e0794daa1fd4f40e6df7704bcec59a5bd4c3203e795f"
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

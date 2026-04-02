class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.872"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.872/nuon_darwin_amd64"
    sha256 "367d125a80be3f510f07add897b7c71210b09ad4588e24e8973c00adfa7f6b55"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.872/nuon_darwin_arm64"
    sha256 "d7acf9626f000050b4d40f693be9dafe1447618210229209a0afc8c907ee798d"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.872/nuon_linux_amd64"
    sha256 "3e7e8d73aead5e6a511114c1bd7d29ca4b619a2ef662f259e44c6c446ec96bd3"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.872/nuon_linux_arm"
    sha256 "b5281e2bcbe972678e39e991e7757a72dafb7cbf33b285b0ec93b5be8cc3040b"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.872/nuon_linux_arm64"
    sha256 "c6510d4631d06aac08086f3a6203c5409083fe4d059a87b099aa7dd9c4f2523b"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.872/nuon-lsp_darwin_amd64"
      sha256 "71de4c48157b6e9ed2eb3d841effa894e87a00c8c3d5632f42a15f1b13fbdeb7"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.872/nuon-lsp_darwin_arm64"
      sha256 "104b6f754ac83fd51878035d1a10cea3da4103d5a38c0f416c924894fa099702"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.872/nuon-lsp_linux_amd64"
      sha256 "12716d028b174ab18ca12c51d916fdeb860002e739a99e7ab0e8b8d9ef64a580"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.872/nuon-lsp_linux_arm"
      sha256 "82b0bb5b58240688ec983902fa3c099598eb4f3fb8c005871c563e7c7433c0cb"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.872/nuon-lsp_linux_arm64"
      sha256 "614e923dbd00c42005c7579af39fd8fd2cd1a72c5558e30a0d12aa0edb29d080"
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

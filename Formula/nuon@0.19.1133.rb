class NuonAT0191133 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1133"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1133/nuon_darwin_amd64"
    sha256 "dcb285a1611a44253dc55f8fc61d1f1d9cb7f18c29c72b17e457d52d46ce1916"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1133/nuon_darwin_arm64"
    sha256 "326f473e71e88039d679c9684a943a240ef4787f5d4e12933da48676798773db"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1133/nuon_linux_amd64"
    sha256 "29e4facd5916e94722117bef16ed6285ea221f4db0da11652f98ba56fc6356bf"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1133/nuon_linux_arm"
    sha256 "24ef097cbd0d01d55cc824ce712b3831d0eb0e4bd6021929120f68d664f1b498"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1133/nuon_linux_arm64"
    sha256 "2815ab8715f404c1e552688b464ab1ff904b19748b94d125054322f739d8803d"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1133/nuon-lsp_darwin_amd64"
      sha256 "ed73b4534646b87634e8c7d4a41ab667cec1ab5a4b7a9fcad3f1fe1541285b07"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1133/nuon-lsp_darwin_arm64"
      sha256 "347adea0eaf8d5b8ea646d2f765b3fccf0cae94a0dcf26884183c2b6ad63b9a8"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1133/nuon-lsp_linux_amd64"
      sha256 "8a9e9b2ae5caf8c085c5dfeefd6e8a3fc2f42e029a8bb91032fc8941a3de4c40"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1133/nuon-lsp_linux_arm"
      sha256 "2853a40c5e63f5f203cbf04715751aff7d4438c2eadd7b4fcccd8c8950bddd63"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1133/nuon-lsp_linux_arm64"
      sha256 "95c1ac2f7dc0a37e00fda400fe02b82b98ff824afca6a62d77a14ac63424efc4"
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

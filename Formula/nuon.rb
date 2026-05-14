class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.936"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.936/nuon_darwin_amd64"
    sha256 "38933aa93081e9388d62ebf09d66ba95677e0d99c345356d75a85cf8a86990de"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.936/nuon_darwin_arm64"
    sha256 "b38580a7ad3b34ec25296041346083aa57621aa654cc8849f079ef9252fc7615"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.936/nuon_linux_amd64"
    sha256 "1f3ca1de942a8fc51e1f8c5f771d695264dd5c1cc97a410723b8a6e1720ef774"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.936/nuon_linux_arm"
    sha256 "fff8a00fa67c114902c7235712e1089d895a583acace399addf36454f0f7bc8c"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.936/nuon_linux_arm64"
    sha256 "b302b8d514ae3aa821ccbbbf78df0a3cbb5222b9b2a78e70c59c0a2d6771140c"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.936/nuon-lsp_darwin_amd64"
      sha256 "c7db0f8831cc472f839d735be92b3c6d1329cafddc9a6363c6ff415dc7bde72d"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.936/nuon-lsp_darwin_arm64"
      sha256 "80d87f260fd5994868877b872c3c79dd1e974c4441d8ed745fa2f22bc27c7ca7"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.936/nuon-lsp_linux_amd64"
      sha256 "cac045e3cf768e12018ec4b43d1b1c1383a1085a52875c0ab050c2e381d1330f"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.936/nuon-lsp_linux_arm"
      sha256 "eca5c5a8543fc389f6dcf0593cf300873b28bda1cc0f2e51c20dc49b2f060126"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.936/nuon-lsp_linux_arm64"
      sha256 "de92a0986c51e36b46f730c70de6c5820c937ffe7f16f2f4008e23dfd84155e1"
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

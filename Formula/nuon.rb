class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1269"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1269/nuon_darwin_amd64"
    sha256 "ae4680a4ac6987e1012a1b813181c1c0a225b17ccd3b7d031eae3218dc011308"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1269/nuon_darwin_arm64"
    sha256 "0b691fe387ce82a8ae4e0c9c0d477ff8cf81c45cbc66d5a9f8b7cf9e2f340714"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1269/nuon_linux_amd64"
    sha256 "5ab5ccc5efff61605c7123fc16ba331128075038fe6e5fdce411b560f5a00818"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1269/nuon_linux_arm"
    sha256 "2aa4cf7f6d4186b1f30bc8d84ab6937b2955cc278b01ed7ac7b28c2581058898"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1269/nuon_linux_arm64"
    sha256 "f0b442d88962a576a2640757d78b551771b842094ed20a13919dff9bad7737cb"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1269/nuon-lsp_darwin_amd64"
      sha256 "fffc7b9b419bc83f2fca56d03cfe038593d4df37a505ac44c4989408e6b8b200"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1269/nuon-lsp_darwin_arm64"
      sha256 "830a9c2174aa3cbf7848b57d361910ba090e147e61e295643128a3001c25062f"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1269/nuon-lsp_linux_amd64"
      sha256 "4d61d577408119b125b860e10b41bec6a157a5080211bc2ee17607f80cbd9860"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1269/nuon-lsp_linux_arm"
      sha256 "5d43dc3869ed85a7461243953037284c84e4a048c59d63d70fb6e628f6fc27df"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1269/nuon-lsp_linux_arm64"
      sha256 "68f278ed6cab14aa243c93881a894b55c58f5e38785ee278470bde69c91c5528"
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

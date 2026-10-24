class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1262"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1262/nuon_darwin_amd64"
    sha256 "54ff9954cabaaace279ec4ce185a1eb941107ea55379e65d297676868faba25d"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1262/nuon_darwin_arm64"
    sha256 "5f72640e1b86db857b383d376c647611315b3ac9c06073427775db2b21b5479d"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1262/nuon_linux_amd64"
    sha256 "b9bc5719dc832e9e08fbf87e9163eb985dafd7ec56c0b0f0227ea25eca3c027b"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1262/nuon_linux_arm"
    sha256 "072b254cf05d4ee72f6accebb0d297aa275243adf88fda71fce9ae02edd6a49b"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1262/nuon_linux_arm64"
    sha256 "029fc8ac932fc29cabdeecfe8cc9f9a2a0ea6624d86f2d3d3ea46f118c1968e7"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1262/nuon-lsp_darwin_amd64"
      sha256 "40eb6a0653ee728e3fe70b0afa39c6fe27a5604b16eed938947ae233df2dfe01"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1262/nuon-lsp_darwin_arm64"
      sha256 "7401d6b17ed5939f7504f272e7c47050387454763c685161e85d973613c3e0bc"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1262/nuon-lsp_linux_amd64"
      sha256 "b4858c25d99e6681c4fc5e52ea5ba3170c80b78e9bf2cd8098906517bf48e9c7"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1262/nuon-lsp_linux_arm"
      sha256 "1691373c2b022f4fa13ffac4a7bbc9601012c5620b9139916bf39142b3e89c4f"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1262/nuon-lsp_linux_arm64"
      sha256 "249496836e2d46a8268e3a83ea6e0934d3ea6371b8b06951526b6a3d4d7a4cb6"
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

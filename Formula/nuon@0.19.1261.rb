class NuonAT0191261 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1261"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1261/nuon_darwin_amd64"
    sha256 "79a0cf77029f9485c316ff0f677157101d3edc0e8a16899ed3b2a65f4ca5a24d"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1261/nuon_darwin_arm64"
    sha256 "1374a47aac733d7cf080d40aa8c18f7d4c1fd10fb60870a81c52e415a9c34f1b"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1261/nuon_linux_amd64"
    sha256 "193a0393602e30921c388034a3425bbf2a40a03ad6c3eb315ade5743ae9a79e7"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1261/nuon_linux_arm"
    sha256 "e3183345477b262cf36acd3522e286e25946a6f997b8271360abcc9bae642ef8"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1261/nuon_linux_arm64"
    sha256 "68d6ac33e2c93ff45c1d0ef4d2b4f67b75263951f6083ec053e4f370f4162388"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1261/nuon-lsp_darwin_amd64"
      sha256 "40eb6a0653ee728e3fe70b0afa39c6fe27a5604b16eed938947ae233df2dfe01"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1261/nuon-lsp_darwin_arm64"
      sha256 "7401d6b17ed5939f7504f272e7c47050387454763c685161e85d973613c3e0bc"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1261/nuon-lsp_linux_amd64"
      sha256 "b4858c25d99e6681c4fc5e52ea5ba3170c80b78e9bf2cd8098906517bf48e9c7"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1261/nuon-lsp_linux_arm"
      sha256 "1691373c2b022f4fa13ffac4a7bbc9601012c5620b9139916bf39142b3e89c4f"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1261/nuon-lsp_linux_arm64"
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

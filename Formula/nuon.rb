class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.991"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.991/nuon_darwin_amd64"
    sha256 "b67d33c7e32cd1b9eaf7926bf99ce988735376e8310089a56b3692c1c0e2a5f7"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.991/nuon_darwin_arm64"
    sha256 "0470b72c6ec2ebefb6303a13bbe5184533f446ba144ec5721a1ba05eeb374c39"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.991/nuon_linux_amd64"
    sha256 "be9c3c52ea30d73005b07b34b3ff493c585aa277d5f4d803d72b7d481e12dac3"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.991/nuon_linux_arm"
    sha256 "2a9638492c5dd1edbc69c5478d70a985ec95e2c3b63abee8533189033d215b0f"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.991/nuon_linux_arm64"
    sha256 "cde1a60b627af7464ff1f65c566c47bdd9efb47ddf93610e9b883c5990d6da8f"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.991/nuon-lsp_darwin_amd64"
      sha256 "ab4fb039ce402ccde7d86813762038c7fe4fa85f1e8017cfea41105109bb97b5"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.991/nuon-lsp_darwin_arm64"
      sha256 "1bd66769128912b202152ac2c857ed34445c91a2eec8cebc79ec6ee1076e692d"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.991/nuon-lsp_linux_amd64"
      sha256 "f12191a35c65cf6dfc40411444229c5d6fa861d0a741f583009f02a1dfa28448"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.991/nuon-lsp_linux_arm"
      sha256 "de6d6462eb9d93492136f9c02edb66e75c9a8294f5868b4fbe4be9ecf6f6f852"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.991/nuon-lsp_linux_arm64"
      sha256 "5a78bffcb6b7e44a120b43143f0da11626cc0d8e49a923a756b2a344db31bb67"
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

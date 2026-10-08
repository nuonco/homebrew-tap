class NuonAT0191236 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1236"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1236/nuon_darwin_amd64"
    sha256 "c21694c66da033a621c8e210cc79de355bdcf8a483cf7983ee38beb9d83ee53c"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1236/nuon_darwin_arm64"
    sha256 "827c52b4a8fe943346ec4fc6e64ee0f1560d327adf07f35a5143456fab50ae6e"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1236/nuon_linux_amd64"
    sha256 "5285564b80c5bf624c3aac4bf7afc6a3908ba0960569c728c0dd674f539df1ab"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1236/nuon_linux_arm"
    sha256 "cc84de1b388814d5892d533a4b3318703397279e19a00eae40dcba7779c14bb6"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1236/nuon_linux_arm64"
    sha256 "5ec502c5b533bb6a75e7e1074bd10d59adba298bbfbce7b4bf408fdbf0d2d0c9"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1236/nuon-lsp_darwin_amd64"
      sha256 "79975ee4b852b6228499ecaa0eab46b15919bca62e293eb45a778c4e165b6ee6"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1236/nuon-lsp_darwin_arm64"
      sha256 "62b31650c9fda33ddd81c48d981ff3582e47119bacfa9fa79bd6005d1f0829ab"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1236/nuon-lsp_linux_amd64"
      sha256 "5bbf589e745d7ee66457a9143e551ec2c5c14a9d577677536bfc7d29cc4c124f"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1236/nuon-lsp_linux_arm"
      sha256 "bdc21dfa97ffa675d7ca201b6b557b2fb4262c4edb6353016a7c9007e75a7072"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1236/nuon-lsp_linux_arm64"
      sha256 "0362f17837f37f4613bd82c712cafe4aeafb071648cd576440f7029d2ccf8569"
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

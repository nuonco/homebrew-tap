class NuonAT0191121 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1121"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1121/nuon_darwin_amd64"
    sha256 "f2269341b32c452b05a8e12a09b95ef0f6d1ed63da96380714a910f4113a2127"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1121/nuon_darwin_arm64"
    sha256 "7c9902554f9cada5a8a967f35a9781b7b666f2e4b7aa7539265dba7c39464f96"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1121/nuon_linux_amd64"
    sha256 "06f978d821af33e10802069ffe94101632ac695c17aa1f32283f2bfac6668b2e"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1121/nuon_linux_arm"
    sha256 "eec2a00e6c7ec33447d930f1681a8a4773c32c0e2bc5226ea88e92a77731e563"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1121/nuon_linux_arm64"
    sha256 "77a294dd5847792877d8a46adeeb8cbee6cfb7d37c7336ee6c549d71efc397cc"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1121/nuon-lsp_darwin_amd64"
      sha256 "5bd4fb9689efc6da5be33eb6fec7e49031899b7f770b2a740b6bec06146eeba2"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1121/nuon-lsp_darwin_arm64"
      sha256 "266edd23fcd2bbf896d5500507ff02d314eac34363e95b3214f7ea1062e66d00"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1121/nuon-lsp_linux_amd64"
      sha256 "4695c54b667d0628f5c713510a56b7957e087f63134b8f75dc1631d33b9c9aa7"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1121/nuon-lsp_linux_arm"
      sha256 "332f657c6daae87914a3c6f6c802ee5b74fced6e99695f58d1abcde93740be66"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1121/nuon-lsp_linux_arm64"
      sha256 "521bc4a067538ec9ee2d0698cfad2394b5890e62ea7c9a0e5b8220a47591963d"
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

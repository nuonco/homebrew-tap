class NuonAT0191093 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1093"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1093/nuon_darwin_amd64"
    sha256 "d703267cb06e229fd491dc61ed5e108200ef0cd0db81ae915a61e5eae490b98a"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1093/nuon_darwin_arm64"
    sha256 "a58041d16a22cb187f98d511e0decc6d4d7225187fc18d23265af7a38a6614c1"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1093/nuon_linux_amd64"
    sha256 "22642e93af1c63d8d492465d0356446442f78aba1e1f77d821ab1ed38fe84df3"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1093/nuon_linux_arm"
    sha256 "b4cb6365d7b472f876dfc359d3876da80d2aba8747f82eff0825a74a24209442"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1093/nuon_linux_arm64"
    sha256 "702b3afb5bfe202657f7b4a60e03c6d5dcf527c464c8478506844912f3dec9b8"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1093/nuon-lsp_darwin_amd64"
      sha256 "ad1a301945d9bec1608e24b6816b5c2a724454796998e4dd7d044ca4db45517f"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1093/nuon-lsp_darwin_arm64"
      sha256 "e8b09924562a38f5e0e94eb6025db042bf07ea0ae24688101b2d63dc0d6a13e1"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1093/nuon-lsp_linux_amd64"
      sha256 "b25b557d8601978169033d3072cedcdcb602761d312d47ddc0fe5c9647f16c02"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1093/nuon-lsp_linux_arm"
      sha256 "2db4193bf67bcbcc9656ba3ee3a701b3a42f092bee21474c6d3c07eeeba9058c"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1093/nuon-lsp_linux_arm64"
      sha256 "b5bdb942c17b42a17113e59b8483a0f9f49656538931a52fa2d19a6d2c31e213"
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

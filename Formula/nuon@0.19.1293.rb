class NuonAT0191293 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1293"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1293/nuon_darwin_amd64"
    sha256 "9b9b98c69b824833357a57857315d3900c92d9263aa635177f340406f6e325ad"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1293/nuon_darwin_arm64"
    sha256 "b58853c7cffc2acd98eecdf249a4eeddbca33e58a661d15305bb0b891fbed278"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1293/nuon_linux_amd64"
    sha256 "2de5351911f8b3b6527c7a41e1662629933277df7f57453e40cf92d06a47efd8"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1293/nuon_linux_arm"
    sha256 "aa3834718ec5a8fc12bc1a2783351bab0d81ed03362e46b5f925837bf040feb5"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1293/nuon_linux_arm64"
    sha256 "1528c34fd5be7de8f9cc7208b35267adca234118627ce9e64dea2276ca29f250"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1293/nuon-lsp_darwin_amd64"
      sha256 "fca25cdbd2efcffe7c1d7da14e49ced5ffd4812749e7e10921b9ae984adfe06f"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1293/nuon-lsp_darwin_arm64"
      sha256 "612c4576039e23771f885b0df5efc9ccff8bedb0565dfa102c104a2b91451d1f"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1293/nuon-lsp_linux_amd64"
      sha256 "3f3e1d0b13a49720e46ba22758759ef7fd751da4d2ddf1704a72b58490b79309"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1293/nuon-lsp_linux_arm"
      sha256 "40feb3ec5858f126cfaab2068c4997a1afe98f4773aadfb7ae224fd0f5c8994a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1293/nuon-lsp_linux_arm64"
      sha256 "081ec4d6d8f06a76f66d24a8cc69d828128db3d216d034646d1e2504f84929af"
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

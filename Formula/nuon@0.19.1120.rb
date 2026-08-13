class NuonAT0191120 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1120"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1120/nuon_darwin_amd64"
    sha256 "154c40018680240b7fdbd6933445978e73ef45408315dd22c5cffce0294f1562"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1120/nuon_darwin_arm64"
    sha256 "a02657ea4474eacc48f863f4cc4658ed9ad9fbdf04e7684f0563850222060581"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1120/nuon_linux_amd64"
    sha256 "5eac7d0228a09807789bf0ba998d1e0e73af9cb8b0818092d562894084ab682e"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1120/nuon_linux_arm"
    sha256 "133f9a11349e6f3bf2d9202a68d4b2707d6908c0ae9010683f136da0bae9db33"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1120/nuon_linux_arm64"
    sha256 "5b9cdbb10705d20df62eadf44945fe056ee125aa612321d570f9ca75fd1400be"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1120/nuon-lsp_darwin_amd64"
      sha256 "c0b77e186d699dd2bac41aec99c0147fcdddf42af57e2724680382f30e82e5ad"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1120/nuon-lsp_darwin_arm64"
      sha256 "c4565118d3e55e4c070db479b5cb6c0168887ff403a3569451d47ac0449b2977"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1120/nuon-lsp_linux_amd64"
      sha256 "550b3e9fb38502a1f36be7024997f85ebdb97221c17edc7385add6c1a4b4c946"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1120/nuon-lsp_linux_arm"
      sha256 "8b1f2628a7a528d030d7729667815095671bcf0e5f81f35c8f86effbc60d2aaf"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1120/nuon-lsp_linux_arm64"
      sha256 "87b192dcf5bbb7bdfb5af217a658ebdcd74ba588b070d79821bca0aa2ce5558a"
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

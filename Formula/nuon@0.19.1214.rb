class NuonAT0191214 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1214"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1214/nuon_darwin_amd64"
    sha256 "544228c171da71f376fca1a3f9e712ea825aa85d2d9e0f4a0a3505a5fb147815"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1214/nuon_darwin_arm64"
    sha256 "5a3a4afc2b64e3265b984891de18fb7b0fdcd5056c23f9a78d4507f0bc38c68b"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1214/nuon_linux_amd64"
    sha256 "2d1270974715047e6eb328a079bae0455ccd332869017374a3e5f75f0609900c"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1214/nuon_linux_arm"
    sha256 "81975fccda448815fc3ee3675ebe5f7c027a670323258fb88aa78f2dca67f10e"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1214/nuon_linux_arm64"
    sha256 "4a2dc489147a0b949357854f85a8d61a01faae0971177ef590e0f6bad9eb4b77"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1214/nuon-lsp_darwin_amd64"
      sha256 "f7547fca065a181beb3264bac9038d2d84486ade3bc1671dfbbb7d63279116c4"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1214/nuon-lsp_darwin_arm64"
      sha256 "be806acc567c49b1040c95b6244d1e62afe907dcd83f72e9f967da7a14432c0b"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1214/nuon-lsp_linux_amd64"
      sha256 "b22cfecdf636dd4806c6d756816b2833da32ed827d6b8c2dcf1f9be69350c163"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1214/nuon-lsp_linux_arm"
      sha256 "1bf998eecd356d9b0744c0f86a3acae60d298bae51b2e0be69e8d11614ea4e1f"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1214/nuon-lsp_linux_arm64"
      sha256 "9a60f25071800844ecc6c844e46a0ce7f85d17b0d65aa5aac3741b544ca0ed27"
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

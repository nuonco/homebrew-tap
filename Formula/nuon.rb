class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1298"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1298/nuon_darwin_amd64"
    sha256 "514f5753d2927268dd7bd174d06ba2bd740cbacac42ab0d7038f68d1c9e1189f"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1298/nuon_darwin_arm64"
    sha256 "2e03b530036e9c116b9d89ea56d4c5fb62f910a7d41dd910051229fe65581a57"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1298/nuon_linux_amd64"
    sha256 "4f625748af29f67f8a0460a2a166a692477c05a92128c36fe69405c129d21a90"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1298/nuon_linux_arm"
    sha256 "f59d1874d27e78bdcdcb9a0566b559e248e5e9edefcc4a53179258182efabcf2"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1298/nuon_linux_arm64"
    sha256 "d33e3daab55b7f6fb0b53f397d280a5107e0b5fbf5cb0b13b47d9fcc4c1e3b1b"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1298/nuon-lsp_darwin_amd64"
      sha256 "f103999e3f6575b7d646f61eb72c5673b7c71ce380dac17297acd34c2e555633"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1298/nuon-lsp_darwin_arm64"
      sha256 "cf816944f973b893b8450ff06acfebf5be564d066845333ea3fa7513f95932ae"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1298/nuon-lsp_linux_amd64"
      sha256 "83e45e12d4861e242dff5a413fa663a6f97abddd9e76368667647b9d7ded5ffa"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1298/nuon-lsp_linux_arm"
      sha256 "30735a55a3e7eadb050c9b083835fc345fa1b62c01d884dcffe1ce79877154e9"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1298/nuon-lsp_linux_arm64"
      sha256 "f621d5aab79c87ff7e32eb9a04ae7451acd144d35ed92bc71044b0b5e921c08d"
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

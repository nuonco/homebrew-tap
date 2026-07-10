class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1049"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1049/nuon_darwin_amd64"
    sha256 "b4db8a0212416aced8d849a52d1be44c275f2b48828a5e16aa5156b0d4a612a9"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1049/nuon_darwin_arm64"
    sha256 "fdcda88d7c8596fb345e7acc88a0cb32dce0204621fe1fabda1c8ad6607267bc"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1049/nuon_linux_amd64"
    sha256 "9a15191325f45c259f5f190793fd76917089405a45b086c8997ea21a5281e60c"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1049/nuon_linux_arm"
    sha256 "a41c211ffa459fe97e0efcddc847ca59d559b96663b64dfb9595fbbe8573ea9a"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1049/nuon_linux_arm64"
    sha256 "69bdec78c45edc9b67492b82a0803a2cad809e0874a0980098204761e365b69b"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1049/nuon-lsp_darwin_amd64"
      sha256 "aadecd13f50494a2a3f27352d5903925c2f8d3c1b66b8a64876a4f77e8d47d73"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1049/nuon-lsp_darwin_arm64"
      sha256 "65f4eff95e6c7569fdb00fce3ce19fe4f44459f44304708e2378ae808b58e727"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1049/nuon-lsp_linux_amd64"
      sha256 "fdf3bdbb6281713360ed4438240d11d001ab1114d7bff4dca68cbc7b2db64fdd"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1049/nuon-lsp_linux_arm"
      sha256 "63fecefbf5ea39084c535b109708603be619431e52dd6d2a7d6016ea560c5356"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1049/nuon-lsp_linux_arm64"
      sha256 "9bf22214241611da845ce067407a584056cd77d513a9e526d3c184c3f875aff0"
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

class NuonAT0191128 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1128"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1128/nuon_darwin_amd64"
    sha256 "5638810a2e1096c1c53c76f86b8f81200d3b794690d5b0db997a0e8cb6608a9a"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1128/nuon_darwin_arm64"
    sha256 "e6b272842f2697d9521b719b5185398cf51aea412d478404676714c48cb85360"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1128/nuon_linux_amd64"
    sha256 "023874df3d59cb28c0091fb36ebaaf62004da90fe0f19da54a3b3c8498055cab"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1128/nuon_linux_arm"
    sha256 "4e95e667a988120740dca80c4985685c4b237563f5e7a01b7019215b187d2ef2"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1128/nuon_linux_arm64"
    sha256 "9d9665b8ba3d078270876a4ebaba100c5260b1ccefd3c4ebf67ceab6eae6320d"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1128/nuon-lsp_darwin_amd64"
      sha256 "e8957adb1c4b347be2ca86f119d5fbb4ffe1eb74588cbbfc505b129daf1ecb6e"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1128/nuon-lsp_darwin_arm64"
      sha256 "6e1827a019b7ed53b05b056ac9da2ab2cbf838f6240427a4f420aa7b9737667a"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1128/nuon-lsp_linux_amd64"
      sha256 "ca49f00be0a516d9220265ea7be2cf60fa4daceacd114a9037e8798409411fbe"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1128/nuon-lsp_linux_arm"
      sha256 "edf592078f3b3e427f6c33512ab1e23c90ea8d04b7b9842dd0ad932b145ef5af"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1128/nuon-lsp_linux_arm64"
      sha256 "80aacae376fff8438c2aed2da0174e7b53b3e5e402c17a6fe3d01f1df3d32db8"
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

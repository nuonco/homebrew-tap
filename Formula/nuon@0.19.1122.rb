class NuonAT0191122 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1122"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1122/nuon_darwin_amd64"
    sha256 "df37123796bebb9f8e9c3ed81f0c776dadd7ba1b5caebc84c1403ffb9f03a658"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1122/nuon_darwin_arm64"
    sha256 "a5384e7c9c14b2453a103935d6e87dbdc00190b2065b9e9f0ffa4339ba1fa38c"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1122/nuon_linux_amd64"
    sha256 "58078a6381ef875d7c636b6a512a0eb431a2bc3c703dd2562c07fc2ba63e2fe3"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1122/nuon_linux_arm"
    sha256 "fee07003ddb35d192f5c003d852965dd2463412a8913bd2045e60653807cfad2"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1122/nuon_linux_arm64"
    sha256 "d83f05c980f8959eccb5e6aebd4d50a14c2022f3db1da9b371b4b2fed09171ce"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1122/nuon-lsp_darwin_amd64"
      sha256 "5bd4fb9689efc6da5be33eb6fec7e49031899b7f770b2a740b6bec06146eeba2"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1122/nuon-lsp_darwin_arm64"
      sha256 "266edd23fcd2bbf896d5500507ff02d314eac34363e95b3214f7ea1062e66d00"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1122/nuon-lsp_linux_amd64"
      sha256 "4695c54b667d0628f5c713510a56b7957e087f63134b8f75dc1631d33b9c9aa7"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1122/nuon-lsp_linux_arm"
      sha256 "332f657c6daae87914a3c6f6c802ee5b74fced6e99695f58d1abcde93740be66"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1122/nuon-lsp_linux_arm64"
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

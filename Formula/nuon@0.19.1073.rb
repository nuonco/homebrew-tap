class NuonAT0191073 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1073"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1073/nuon_darwin_amd64"
    sha256 "f89c481bade085eddf45ea19911f5022dc74400d8b371f683fa379e2fe645682"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1073/nuon_darwin_arm64"
    sha256 "10958023b1ef7330d2c6575dac08afb9bd0d37e2a1a9c79921b0d10a58c94b46"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1073/nuon_linux_amd64"
    sha256 "756fc548bcb9f1cbd66d9a1f83d809bc0eaaf8a0f5b1da0bb3a29f59c8c84c9e"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1073/nuon_linux_arm"
    sha256 "860414454864ab296714cff068f7424d2ae118585a96c31fd2714c213f23dfbc"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1073/nuon_linux_arm64"
    sha256 "4b20591b8ff12ed4759eb40da7e1a483f6b700ab48188c5d6872a50ddf9e97ec"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1073/nuon-lsp_darwin_amd64"
      sha256 "828f8111c7cc9fa9a517dea9fedfdef944abcafa590ab5d2626a8e02bc460653"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1073/nuon-lsp_darwin_arm64"
      sha256 "67a94f754dbb9053f9dfd57bf910a2d08d39eb195e7b75468600de6033f1d554"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1073/nuon-lsp_linux_amd64"
      sha256 "95fc049c60d5a6c50572758941ea66fff1d944dc5293f001c10f766065b9d5f3"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1073/nuon-lsp_linux_arm"
      sha256 "ea645832cc2876ca4b1b1256f5b9a577e8166a0ccae4a14f4df9fcfb0bd96139"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1073/nuon-lsp_linux_arm64"
      sha256 "30c86ec8893abc3c7b7139fa3f88344e538cd890f2db26288bb0bcf14ccc649d"
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

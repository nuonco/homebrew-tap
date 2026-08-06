class NuonAT0191110 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1110"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1110/nuon_darwin_amd64"
    sha256 "9f8154adca2a08ebc78d9f47eeb3033c2c0d2580831673fc40f6fd8fa7eb6d84"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1110/nuon_darwin_arm64"
    sha256 "2991be479a34ec9658508eddee1cc26be0bc24078fadcebb5c476b814ae4e581"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1110/nuon_linux_amd64"
    sha256 "61dbe1fd9a71eb239881eb01668ac9e62023ace1888d643d5d98b12398319bca"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1110/nuon_linux_arm"
    sha256 "aff2813168b2d334f4601e9381e25f3d6607eb798ad782c8d1bae26b2307d169"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1110/nuon_linux_arm64"
    sha256 "59856030d14e600323e1b94dfe69ec9b926f2118cf10ac1babbe4fd6b320ed20"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1110/nuon-lsp_darwin_amd64"
      sha256 "7b8e52bc2290d0b3ac86e1a3110699fe70d843f334f791f58130d8742e33ea2d"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1110/nuon-lsp_darwin_arm64"
      sha256 "b4412224b5d117622e25978c3ce172cf424fc2d5eacf8d1964e9e69f40b4f534"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1110/nuon-lsp_linux_amd64"
      sha256 "7ae79fc836dc847a13072e4bf4e5b162b2354b488b62c7aebd0637a3b80d9d97"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1110/nuon-lsp_linux_arm"
      sha256 "576fe6b311b5b2330d752388b93ed63226e966076bf9867651069da53280a769"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1110/nuon-lsp_linux_arm64"
      sha256 "ff40f56346950252dac7ae960364f3b5e9df156ea23255e6661cedd54f391657"
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

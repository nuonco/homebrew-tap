class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.954"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.954/nuon_darwin_amd64"
    sha256 "27d4ad642c9fea604339ccc41a67a407cd556b399954975327c2f6e2014a4946"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.954/nuon_darwin_arm64"
    sha256 "5109bdfa7a81a7b96228f263cfc84bf5d5190c7e23d9b8489ff80f3c35c134b8"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.954/nuon_linux_amd64"
    sha256 "704547efad8fc6e0ba50eb651128cbe0f155c3fea9792f8eb1430b3959e9ceab"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.954/nuon_linux_arm"
    sha256 "0f90d62804ba5bf91e61826a0c76459b1f12c094e239c154647a5c8df16422ec"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.954/nuon_linux_arm64"
    sha256 "680c7e1be247182693ab23a365c37e1f45098564151d5c3b21525b6ef637979a"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.954/nuon-lsp_darwin_amd64"
      sha256 "0c5aaaa4fd779acf54cfc98b734aebd2c44b8ad3ac23a1936ee8db2096d0ebd8"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.954/nuon-lsp_darwin_arm64"
      sha256 "15889ca4311cd73e4c1f0ded3a43c3deb5b637f78ea26ac64de01df401de4496"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.954/nuon-lsp_linux_amd64"
      sha256 "cf4702218e91b9f6b86bd514fc45772e9a6858427357635c8c29f40c002b3cea"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.954/nuon-lsp_linux_arm"
      sha256 "ce99cc03eb0595cc2de5def48d72fc12de13025b1b97f40743c43d506a5df41e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.954/nuon-lsp_linux_arm64"
      sha256 "9a0a14df42a573309f4f2e6ff5a981ada07cd5760f164cbfd5ea1f6218a41371"
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

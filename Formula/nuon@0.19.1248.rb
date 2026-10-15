class NuonAT0191248 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1248"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1248/nuon_darwin_amd64"
    sha256 "2870c26cedc862275d6915ab6137d76919223842200f5aa9d0cfdb54ac2d03ed"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1248/nuon_darwin_arm64"
    sha256 "a32804ea77d8d2f98aacda35d687813d08bb084d3c98cc53622a1bff9ac665ac"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1248/nuon_linux_amd64"
    sha256 "f98192071ce3a8524baf46ce297417a05829a3e5cca7002d93ee5f59d5157f5e"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1248/nuon_linux_arm"
    sha256 "e6ba5fef98b01da81c140a569686be2343b7e251fb86ef9f7700bdc5ece6e9e3"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1248/nuon_linux_arm64"
    sha256 "0e51693e4267a4ea5523bda9d0ad26d6c411cc1f38727195129c9aa173358e15"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1248/nuon-lsp_darwin_amd64"
      sha256 "6b9b3ccbe1c83738a30814c7927d493f30851861bb951b588a948ab5cd09b0a4"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1248/nuon-lsp_darwin_arm64"
      sha256 "bd8ebddbbb38e14d96ff00feb7d95ea06930b90b0bdc018d5e214ff882e22541"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1248/nuon-lsp_linux_amd64"
      sha256 "10b46bd0252e58dd59d09561663380e4ff2f397d01d373831c85ee9bfd930324"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1248/nuon-lsp_linux_arm"
      sha256 "c8e30988f8c3327d282d52d3290e0df52045f25e1c1f01e5adf51abf65a3482e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1248/nuon-lsp_linux_arm64"
      sha256 "950a6b0c2f41bb929eae63c3ab4c7fd074a1d9b164299bc4fa0ca3fd0eac7913"
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

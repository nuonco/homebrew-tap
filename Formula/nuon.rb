class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.790"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.790/nuon_darwin_amd64"
    sha256 "39cd8464bfafb4f11254d742167afa587696a61c8caa1fa6c8792e1613ad0d4f"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.790/nuon_darwin_arm64"
    sha256 "9b5193422bd466a915193baf8983ae74de36f7296525d2b40f5b16ce3bc85c52"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.790/nuon_linux_amd64"
    sha256 "1bb59f3c9d26e19fd6f43d3aed5d42669f0506ccc7554b2d29c8fae5c0de6bfe"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.790/nuon_linux_arm"
    sha256 "58c6d738fe468810204a257dffe4a02212c6ce310d4b45f6d88449496ce052ce"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.790/nuon_linux_arm64"
    sha256 "2d6a5936a9f3bec0faf231ca5fd2569b3f3b22a32c040050aa5adbae05386308"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.790/nuon-lsp_darwin_amd64"
      sha256 "1b08e2842603bfb576a9d382e2f4c1dc91f270c741d23d7c3c7668df3577509d"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.790/nuon-lsp_darwin_arm64"
      sha256 "e76c689e54cb2382a4f78d82f1d6edac1b08156d95d9cd759551de49ee1dcd33"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.790/nuon-lsp_linux_amd64"
      sha256 "883bf5b3bde755f6b7bcbac9e9bed2de1ca65302e03f97c87dee9cd55621d7ff"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.790/nuon-lsp_linux_arm"
      sha256 "0c5fe5a5eda36e472e892c78c17e0453fd28d92510a051edd7938ecaaf7ecd37"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.790/nuon-lsp_linux_arm64"
      sha256 "3775410312001adca66deb6e05d944a86fb0e0c7a3c4ec62b14d5681b014ab78"
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

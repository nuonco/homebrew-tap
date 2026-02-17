class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.788"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.788/nuon_darwin_amd64"
    sha256 "ef54e4b284873d1d2eaa5dca115a5ee58fbeac3590f32868dbaea83a026bbce7"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.788/nuon_darwin_arm64"
    sha256 "aedc1588f4e1959e3bf19196b6d9286ca2a61d7fb93623992ddb9874585043b6"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.788/nuon_linux_amd64"
    sha256 "fc5747bc8060ad476ae2254422e5e25efff19ec953636cdb21def4ddb2b14b93"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.788/nuon_linux_arm"
    sha256 "52369747c9c9b707867cb3ef7926aecdc269240e37814735ff475d170831665c"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.788/nuon_linux_arm64"
    sha256 "707a19825d45cc00b53ba0d05bb3bc611cb57b98b255dd6b6b5c607759845f68"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.788/nuon-lsp_darwin_amd64"
      sha256 "8d19c462562d53883a56f34840af12195480a07e2db9c65eb0022424752a4fe5"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.788/nuon-lsp_darwin_arm64"
      sha256 "7b9c967dd0e39854559658bcf7c8d21df75b3f686026256f715a817e90af6e16"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.788/nuon-lsp_linux_amd64"
      sha256 "426501fece7ec36b1ec1901bcd2cbc36c452e27a15d07ac7d839e45af0b7d3b0"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.788/nuon-lsp_linux_arm"
      sha256 "046b9a2c75172f6406128a63a628d1e1364a8f8e7bb260b334a6b50ea39acfff"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.788/nuon-lsp_linux_arm64"
      sha256 "25a91f6e5d92a7d8607f5411ac858238fa498c7fc754f341ee446414f2f371fe"
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

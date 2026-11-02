class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1280"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1280/nuon_darwin_amd64"
    sha256 "26a84c7df629a6a7e0a648fc8363f248c811f05b8cb4cc63fe892c853f44c541"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1280/nuon_darwin_arm64"
    sha256 "444cc0fa745c241e5b117c91cfa135f18126d7659f1191ef1a48c7a0579c858f"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1280/nuon_linux_amd64"
    sha256 "1e770ed77d0b5aa2364d788299b1ff6e67bd784a060a1cd931a8fd21849d959c"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1280/nuon_linux_arm"
    sha256 "d286ef9fd68ea1dd345c7735a317531f02e006a5453c0b5cd6b3358b0385a4d7"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1280/nuon_linux_arm64"
    sha256 "9bd7c544d791586ad5411b843b7e0975d608acef1c99c97de75ba4a1beaf425a"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1280/nuon-lsp_darwin_amd64"
      sha256 "6e7dee891c5f3941c127f3acd021e3e007df92d961af1939639c819ac4fbae45"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1280/nuon-lsp_darwin_arm64"
      sha256 "d2558ed91f6cf56c9e44e73cec5391ccf8ae650cae4dd79c581d24cd4927f273"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1280/nuon-lsp_linux_amd64"
      sha256 "6ce8e7c5c6792abbb170d4ab53a92c9a4b24178b53e60c53836ba2a551c4fe66"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1280/nuon-lsp_linux_arm"
      sha256 "80e518b499dcbe7996a520daf45cc479c905c1df911721f73d12f64cc0c8470d"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1280/nuon-lsp_linux_arm64"
      sha256 "5c8586030159c10b7b4c3efd7d7b4ee47460b0bb31d806111cf40726777b721a"
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

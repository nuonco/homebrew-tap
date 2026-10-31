class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1277"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1277/nuon_darwin_amd64"
    sha256 "a2a024630249750af1503a871ca53a3542dfa0372d258536a5d6733380628f11"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1277/nuon_darwin_arm64"
    sha256 "66950ab919d2e9c0581fba612110baf6b982abb0948c741a88f7ffcf83ae93e9"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1277/nuon_linux_amd64"
    sha256 "0e8b29b7294ae5516f16e0d0ba543968fe2d70a07c498aa6aac13f8a520333a8"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1277/nuon_linux_arm"
    sha256 "4b7baa09e8abcfb01e7df9c960c17837583a11c394a1f6ce4dd6ac039a878e8a"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1277/nuon_linux_arm64"
    sha256 "69357fa90c8bb69797a8fd9aed22c633f6ebe157d522a0618a66d18e9623288d"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1277/nuon-lsp_darwin_amd64"
      sha256 "6e7dee891c5f3941c127f3acd021e3e007df92d961af1939639c819ac4fbae45"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1277/nuon-lsp_darwin_arm64"
      sha256 "d2558ed91f6cf56c9e44e73cec5391ccf8ae650cae4dd79c581d24cd4927f273"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1277/nuon-lsp_linux_amd64"
      sha256 "6ce8e7c5c6792abbb170d4ab53a92c9a4b24178b53e60c53836ba2a551c4fe66"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1277/nuon-lsp_linux_arm"
      sha256 "80e518b499dcbe7996a520daf45cc479c905c1df911721f73d12f64cc0c8470d"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1277/nuon-lsp_linux_arm64"
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

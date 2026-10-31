class NuonAT0191278 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1278"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1278/nuon_darwin_amd64"
    sha256 "0a84f537259c93583eb1860d3b1d2cad94ed0ea4395f00c5235799202552daaa"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1278/nuon_darwin_arm64"
    sha256 "5b8fca48be78bd68688648a42edf48f9b32797cd798c1df4ae1f8a8149ec4bfc"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1278/nuon_linux_amd64"
    sha256 "7b0cc509d30db4a4e78259e37e7d3cc05457c49a914c7389a8b2910ff624cdf8"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1278/nuon_linux_arm"
    sha256 "6e5debdc7f29ade0a4385877222637365952a44813b5618d746335b87ffca2db"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1278/nuon_linux_arm64"
    sha256 "9194c864cf469e5bdb5e76f694a0dac6ba94c2939fd6e62187d3829059a70d65"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1278/nuon-lsp_darwin_amd64"
      sha256 "6e7dee891c5f3941c127f3acd021e3e007df92d961af1939639c819ac4fbae45"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1278/nuon-lsp_darwin_arm64"
      sha256 "d2558ed91f6cf56c9e44e73cec5391ccf8ae650cae4dd79c581d24cd4927f273"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1278/nuon-lsp_linux_amd64"
      sha256 "6ce8e7c5c6792abbb170d4ab53a92c9a4b24178b53e60c53836ba2a551c4fe66"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1278/nuon-lsp_linux_arm"
      sha256 "80e518b499dcbe7996a520daf45cc479c905c1df911721f73d12f64cc0c8470d"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1278/nuon-lsp_linux_arm64"
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

class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.769"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.769/nuon_darwin_amd64"
    sha256 "847b8eb5c24af1b327f8e0f45723bf215a8392dbd5d0480bb00b040198ed0044"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.769/nuon_darwin_arm64"
    sha256 "183193e643532a950a6205def23cc7c4703d17cdfc0cc893188fdbdcc1c0d005"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.769/nuon_linux_amd64"
    sha256 "fce1ea3491fec40d37c3ba388702a46978c357f74e7a42c26a99c18e6b4c7b70"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.769/nuon_linux_arm"
    sha256 "d38dcc81223509336df110fd4157e41cd75cc7e9ea1a829ce6e0a32ac972cbcf"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.769/nuon_linux_arm64"
    sha256 "47e856291e693e9b37db3fd5a0d7f74055afe20a025d9173c73097aa91715a5c"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.769/nuon-lsp_darwin_amd64"
      sha256 "a95bbbaf1cec5cb2efb8e2eb357ccc88bfce2169c7192081bec133338080d1d2"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.769/nuon-lsp_darwin_arm64"
      sha256 "7b777d1bc8475aa493ff7a8789750ac21a481df46e81b4e7e9f2f0e1b74b4db3"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.769/nuon-lsp_linux_amd64"
      sha256 "ef129edfc912eed1527bfaae673d268cdba3f3d11422bd2388d8013fdccd149c"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.769/nuon-lsp_linux_arm"
      sha256 "9a89fa67f9105f9b92d6404c3f29c698d255f71c55c67d0a80876a2b542c3fbf"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.769/nuon-lsp_linux_arm64"
      sha256 "eb5609e36a6f9ac916d37628b1b92ff0daf74b768df1cdbaf860b7e9780930cb"
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

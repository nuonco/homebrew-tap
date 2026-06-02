class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.986"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.986/nuon_darwin_amd64"
    sha256 "15bf70c417d2019b5ebda6567b273be5de9c1f68c45598968927ed789d7f8b29"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.986/nuon_darwin_arm64"
    sha256 "5a77b51bae761324a8f93b3b7b425909b7ef7a90358099adf30adebfcb3604b2"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.986/nuon_linux_amd64"
    sha256 "642d6aa5314d522a222b0518e435a069ff556f5a5f4011b9e52cec541573373b"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.986/nuon_linux_arm"
    sha256 "44bd528cbfd0af2b5bfc31ad584553341cde7e3a5b29c3753a90e5de1c847cdc"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.986/nuon_linux_arm64"
    sha256 "2b5cbd6baf13647beca3c3f34827a9bb29605d920986c7fd3a4742ef4a83374b"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.986/nuon-lsp_darwin_amd64"
      sha256 "a558ff7c68112ce20b8558b22f10205c3d7445a3970b17215ff8acf28c4c51ab"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.986/nuon-lsp_darwin_arm64"
      sha256 "d35b4d0e1e75ad41ff527494d19096750409dd39abf0e3c5cff170b3f289b35b"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.986/nuon-lsp_linux_amd64"
      sha256 "dc54c70e63bfd261294d5bc9641a703f1246502c31a2ccf0e67b6e2544a30df0"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.986/nuon-lsp_linux_arm"
      sha256 "f1af51146b27076cffe30ff0e1944eb76c151d2f234dd958320a3e4304397abe"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.986/nuon-lsp_linux_arm64"
      sha256 "89451d969c6c48b9c0e81734df4e63d3c299c04cdbc13e510a62e619d43ef26a"
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

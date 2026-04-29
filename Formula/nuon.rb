class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.902"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.902/nuon_darwin_amd64"
    sha256 "9fef500d36d619ad374dc608221b0db1a2cb6563bdb9a5fee2490b3da3f14390"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.902/nuon_darwin_arm64"
    sha256 "d0e03d6a12c38d53a19d275b725b8014d95883f07bda4092579875625f959b71"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.902/nuon_linux_amd64"
    sha256 "6dcf001b1576a0fe914613a5f3549c4077173653d3a659a5f337f410625f4f1a"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.902/nuon_linux_arm"
    sha256 "0f97a800cda7905308c6c0413e87f911acc2d35579aa4a216742491aee5bfcd3"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.902/nuon_linux_arm64"
    sha256 "06038ffdd5e3396f2477008cee2d815b0c7a92ae6fc16762eb68826350a9797d"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.902/nuon-lsp_darwin_amd64"
      sha256 "0c390d8dc9f29a18ceab4d7b8fd6061f70b0700807a475baba5f6fe3fd999f34"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.902/nuon-lsp_darwin_arm64"
      sha256 "12e5bd2d95e91aa5e44c3d20a563d2b933edde9f7c986bb34aef447c15edd633"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.902/nuon-lsp_linux_amd64"
      sha256 "26a7e6059a2e29bd283069ce4163eb11b04d4a7a9d96215d96544c68f8d4920a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.902/nuon-lsp_linux_arm"
      sha256 "0ffcd60bfabba2bd0e349f371e5d656941856986c013258b95cdbdabd024866c"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.902/nuon-lsp_linux_arm64"
      sha256 "5df5cddeb833e80ee50a6d767f480251a93ddbd90848d5aec6f501232ef29d48"
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

class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.901"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.901/nuon_darwin_amd64"
    sha256 "f0ca2c94ab0af97d3d2498c3e514d7988295508b1c0e7147f246773bf6e9c531"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.901/nuon_darwin_arm64"
    sha256 "b58895f8514479fd8a9230ec533be6c67f6bf601a36809a2d9ce51038a81b336"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.901/nuon_linux_amd64"
    sha256 "8b29aacabdfd7bc9d01c0a40d6c5ccfeade2c1d8d8b7b24fdb4f323e3efef02c"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.901/nuon_linux_arm"
    sha256 "d304e05e892aaa101b30e1aad338aeb4fb01d1d10b86e8aa19d24b5cc94c9376"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.901/nuon_linux_arm64"
    sha256 "a2f643de496bbcd621c4f8bd0d593cc9d017c59b407f3967fd0cde67926d8f7a"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.901/nuon-lsp_darwin_amd64"
      sha256 "0c390d8dc9f29a18ceab4d7b8fd6061f70b0700807a475baba5f6fe3fd999f34"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.901/nuon-lsp_darwin_arm64"
      sha256 "12e5bd2d95e91aa5e44c3d20a563d2b933edde9f7c986bb34aef447c15edd633"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.901/nuon-lsp_linux_amd64"
      sha256 "26a7e6059a2e29bd283069ce4163eb11b04d4a7a9d96215d96544c68f8d4920a"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.901/nuon-lsp_linux_arm"
      sha256 "0ffcd60bfabba2bd0e349f371e5d656941856986c013258b95cdbdabd024866c"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.901/nuon-lsp_linux_arm64"
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

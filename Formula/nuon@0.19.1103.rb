class NuonAT0191103 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1103"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1103/nuon_darwin_amd64"
    sha256 "54a695e1d36088193c43ff3888cb89b854fc1c6feaa69ff950a24aa414adb3aa"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1103/nuon_darwin_arm64"
    sha256 "81e69981b0beb2fe0d6b8788a80333c3929ab646f0a76c716603ccc3f2f646b2"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1103/nuon_linux_amd64"
    sha256 "db0eee90255243e4f52a2c31eb71f2a3d5ebfddea7e03793a16ea8c8a0f710dd"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1103/nuon_linux_arm"
    sha256 "df1ef4bdd157da964f51aaf7eed33f8919c5e8f44b108918b9e988423bfa2afd"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1103/nuon_linux_arm64"
    sha256 "3faa682b1504c1c79f17565d693e7545cf993fb8a969b8ff818efee6fb91161a"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1103/nuon-lsp_darwin_amd64"
      sha256 "80fae72aa61bc5259c3b31c22093a22b3080ce33cc902d993160a7bd174793a9"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1103/nuon-lsp_darwin_arm64"
      sha256 "87d86a69683540491149203659f712fd36fe03e1dad8c5d32284d7fc08c6c58d"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1103/nuon-lsp_linux_amd64"
      sha256 "c039323fbb4c9e4142fc4e56748133ef411d864ea549dc7fd82f04c54d60ed38"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1103/nuon-lsp_linux_arm"
      sha256 "d7ac288f1fd00136d1df3714995afa7b50c1243a71cc9bd47d83b3eea34a5e2f"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1103/nuon-lsp_linux_arm64"
      sha256 "5ae2de012ca98b64fa326d83461ff5e671fdb94b4f2e580375b5be6267f5123a"
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

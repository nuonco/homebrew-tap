class NuonAT0191231 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1231"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1231/nuon_darwin_amd64"
    sha256 "784c74d08d4b6743f47c21388f18884225461e38a75c078648435f5240092b9e"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1231/nuon_darwin_arm64"
    sha256 "fca2b2cea8e6fb30b8c7a1a2996a0f6a9b7aa0a8d625319aef3ec9c3688c6ad5"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1231/nuon_linux_amd64"
    sha256 "10aa8a8f7b1af55cb46eacf6f5764ffcb9173df2f795d89e79feab34f6c811fe"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1231/nuon_linux_arm"
    sha256 "a4dbcbb30f26b8b88f2d512bbd5e9d9a5fce774503d9fd3e23ad73d64f452ae4"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1231/nuon_linux_arm64"
    sha256 "d795cb46043773595641997e70992eb5be87065982b84b1cd202d94b2176048b"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1231/nuon-lsp_darwin_amd64"
      sha256 "05f35fc5062bc954d0003cd92f9e917869810196c72533f95a15bac2be85924a"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1231/nuon-lsp_darwin_arm64"
      sha256 "4ce2f01f906385c83a644d83da5801b0c2db294e2201a5960244b7c2a702627a"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1231/nuon-lsp_linux_amd64"
      sha256 "a7964e4f732bdece201cdbf79ec9aead930e6c98896958924d59072b843a1ec3"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1231/nuon-lsp_linux_arm"
      sha256 "3f04f5dd886b4b81d5433c61d280acfaa75f3a972af6a3475b01159e165c83e6"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1231/nuon-lsp_linux_arm64"
      sha256 "df0486e1395d64a24b69541f323f95dc488835d3436524e099134afc7e5e289c"
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

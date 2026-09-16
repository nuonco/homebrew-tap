class NuonAT0191189 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1189"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1189/nuon_darwin_amd64"
    sha256 "9d8fef6181da80a2aaaef414eee7ddfaa1c865f0755b5c0ea7b3153ddc9b0f60"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1189/nuon_darwin_arm64"
    sha256 "a292a933a03c19519b4aac473b6fbafa9269e8e17930f17ffc54425d971fc36b"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1189/nuon_linux_amd64"
    sha256 "2c6d4bcdada3fc28f815de1564a0eb1a09566c4eaa01a812e9cea37a256a0e3d"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1189/nuon_linux_arm"
    sha256 "2958966730684929c8a4d8d379f10dcfbb60dd06460a60b21727b5d56ce6c47a"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1189/nuon_linux_arm64"
    sha256 "6f22a764a8678e18f109c859742b0ce318890416e9958b28719a5b131d8c6980"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1189/nuon-lsp_darwin_amd64"
      sha256 "932436fdfd7e173645049d4fa32fd166130ed6094d9d0092f59ff13f50b19b4d"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1189/nuon-lsp_darwin_arm64"
      sha256 "c0f2233eecc0d994e83626217766bddb9fba5a70c1fa21204cbdcf9aa899835d"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1189/nuon-lsp_linux_amd64"
      sha256 "7d218dde1ea2defaf6dc91a58aa443f6119aefb5354301cc7d116b759a281260"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1189/nuon-lsp_linux_arm"
      sha256 "3cf04872af59df947d500d0fa5b8221bfbb9ea5fbe38f1f98eb30dc82b4ecdbf"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1189/nuon-lsp_linux_arm64"
      sha256 "42857be72162b30bc05b806319400cb6d54489a0fa324cb6c8cb2fefd1f9bd31"
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

class NuonAT0191198 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1198"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1198/nuon_darwin_amd64"
    sha256 "e499e1e8b3c62464b91fdba060fc26f33c6dfc3d222e97cc09fbb04bb7889164"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1198/nuon_darwin_arm64"
    sha256 "7053d47191b7dc05eb7f70cc7cb9c46573f1f313ee63514adc72be5bdd303f3f"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1198/nuon_linux_amd64"
    sha256 "68547711454e6eb395bd2302a0c2c8b906a1a3a1dc673b2ec90bdf05ea9069b0"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1198/nuon_linux_arm"
    sha256 "1ef800a5bb4ee6b5fc0379f1b60eca7b3785fcedd6d9e4a5db44cfa5ae604522"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1198/nuon_linux_arm64"
    sha256 "5378dbf3bd5f4c66f836ea3ee28afd833fa57150de9fe6e3e4c09a82a7cf320c"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1198/nuon-lsp_darwin_amd64"
      sha256 "223eb24a38e4c35fa281b0dfcf88fd100f2c6907895efbcb8b2e919f46b94634"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1198/nuon-lsp_darwin_arm64"
      sha256 "0de520000d7eb0e57ac5fc63e4c8549daa5704a719c64b5a8208be19e8f3e3cb"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1198/nuon-lsp_linux_amd64"
      sha256 "ebc6327e5db1338b2bc7b2dc900f5c35cc8536be8fe6c8c879f1d100944c02a7"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1198/nuon-lsp_linux_arm"
      sha256 "c56537829c2c9ce58e3e1535d1f12dc258d3e0ad61f9db26f805c38847cfce10"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1198/nuon-lsp_linux_arm64"
      sha256 "8b9332c8b7c2d9ec5bcc2d6d9f6028ca645960d0df6490d28ab647e5e0382fa7"
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

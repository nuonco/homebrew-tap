class NuonAT0191105 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1105"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1105/nuon_darwin_amd64"
    sha256 "a88dc50c96901c7a80947be5d17f5664c3082c8c05732f755f4a947421e013df"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1105/nuon_darwin_arm64"
    sha256 "22236d66e456b9d0c803b5b4edcf7361b3b68502e1a98e3d1b54abb29ccd49f7"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1105/nuon_linux_amd64"
    sha256 "9b780440591733a24dc5090ddd986620555872c6b9a9a9702418eb16050e4fc7"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1105/nuon_linux_arm"
    sha256 "a5624fe1920cd0e4e92fe45678c856facd126b620475cf86a3d9a449b4fec8e0"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1105/nuon_linux_arm64"
    sha256 "4ea0ede2feeafbb24998421197eeb7f24b3e05c1461c19ead7950b655d90d7ce"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1105/nuon-lsp_darwin_amd64"
      sha256 "8e280ef9cdbcc2ce542d49596348713b41da150a302746c8cc60a40903a1a1ca"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1105/nuon-lsp_darwin_arm64"
      sha256 "1ef1deead77376bd942440c9ff6d0a2de7e83b31bc1f08ef8e7e186d16caf753"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1105/nuon-lsp_linux_amd64"
      sha256 "258910fea7a7ca5912d91cc2cedc0bd21c5f81ffdc51f2f33d5d018ae2f422f3"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1105/nuon-lsp_linux_arm"
      sha256 "adb927032ad626b929f4b2f4f269523af03638d60e3264d987ff3198292f6cf9"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1105/nuon-lsp_linux_arm64"
      sha256 "0615eefd03f726008c023c85421bc83eed9ace89ec46ba2dbf18e509c4587118"
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

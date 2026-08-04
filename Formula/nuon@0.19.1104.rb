class NuonAT0191104 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1104"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1104/nuon_darwin_amd64"
    sha256 "442f90a2614d01b9e362f9b7e017a5a6a1346240f884961e783a58ddce960021"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1104/nuon_darwin_arm64"
    sha256 "cfb0460c8053b3b812a65d529f0e3eed3b61bb0705a1c37ed88672293e4d6fb7"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1104/nuon_linux_amd64"
    sha256 "d3ba6d603586b455df3f5b1164cc13b6b7ecc3447873ec8bc3c88f2e73e0ebc7"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1104/nuon_linux_arm"
    sha256 "2660decba2760cc775485751a063b1e3a26d0a508b10e8161d9c2385e42eaeed"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1104/nuon_linux_arm64"
    sha256 "55b953c0e2778fa1239176be3d464921b9424f1670e4ce38c955e24ef5a8d957"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1104/nuon-lsp_darwin_amd64"
      sha256 "8e280ef9cdbcc2ce542d49596348713b41da150a302746c8cc60a40903a1a1ca"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1104/nuon-lsp_darwin_arm64"
      sha256 "1ef1deead77376bd942440c9ff6d0a2de7e83b31bc1f08ef8e7e186d16caf753"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1104/nuon-lsp_linux_amd64"
      sha256 "258910fea7a7ca5912d91cc2cedc0bd21c5f81ffdc51f2f33d5d018ae2f422f3"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1104/nuon-lsp_linux_arm"
      sha256 "adb927032ad626b929f4b2f4f269523af03638d60e3264d987ff3198292f6cf9"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1104/nuon-lsp_linux_arm64"
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

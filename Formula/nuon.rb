class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.903"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.903/nuon_darwin_amd64"
    sha256 "cf2019cbf91a136ae8cc82bf630bf4d96f3ea3d600bbd757243f24b6a1d86c1c"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.903/nuon_darwin_arm64"
    sha256 "6c1bcedfbd39a2cb0a6d51b4a9d2e5eb13a3510d748497b5256a6f86add70fb1"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.903/nuon_linux_amd64"
    sha256 "d72216c2f269cbea740bf72206f87bf9848b74057b9826db20af08eb3eaf2cd2"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.903/nuon_linux_arm"
    sha256 "89483f4146d965a5f876bc4902a287a9287735981a43aafd1246b4ace2744617"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.903/nuon_linux_arm64"
    sha256 "9845284724eda4d42173a19991358fed068c5d1540bc02dbc6144b929799a7f3"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.903/nuon-lsp_darwin_amd64"
      sha256 "61799a7faea6b0c2fef1bcc29c05d9b6f33762ade018b50a00d3bd90c6a95201"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.903/nuon-lsp_darwin_arm64"
      sha256 "6e36ab5ad49486a6f9323cfb5e5db17e1fa128a10085d6a950411c4f8229d65a"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.903/nuon-lsp_linux_amd64"
      sha256 "b0e421679981a012124b8e5e2173daabb8d98e6aec883d7350791832a83932ef"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.903/nuon-lsp_linux_arm"
      sha256 "f943ef2fed68482012c1659e72f52a0c695d3a22d029bc5946b76d986a17f859"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.903/nuon-lsp_linux_arm64"
      sha256 "b498344dc430f6df605a6c18619695dc90ed52027983bf3eab2d9adf16d7629f"
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

class NuonAT0191077 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1077"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1077/nuon_darwin_amd64"
    sha256 "15d909716f72c6dbc57292c4ae2dcb71a7fee8238bbe3a47ec16a5e0e7ef65eb"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1077/nuon_darwin_arm64"
    sha256 "b024e133570d4354cf13a10c75177c894f196cc7d3dbc6c1de45b965035db64a"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1077/nuon_linux_amd64"
    sha256 "2acc35f22052dce9f3983191c93e79be414dd911ced94b58082a578d8b3566cd"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1077/nuon_linux_arm"
    sha256 "866b9151a33c9efe91c5c96dd4fd91c586d2b5119bb2364835f2359b2e9caecb"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1077/nuon_linux_arm64"
    sha256 "8c4bfc6fdf3468b3efbe79de686ca2c71c528e2541d85d405fa16b83c33d6638"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1077/nuon-lsp_darwin_amd64"
      sha256 "eb6f293f0b5742b0ef5a16295b0bf452b238626284a87b20885fa336cd53d106"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1077/nuon-lsp_darwin_arm64"
      sha256 "b91a43a02e4579fd71dc025f1757dc2a9a23fd07054fd0097f1eaa087b27c3e6"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1077/nuon-lsp_linux_amd64"
      sha256 "76adb2d082c6eac46733bd9b8aacb21fdb3a3a71e33f52ba0d8d515d6df4fd09"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1077/nuon-lsp_linux_arm"
      sha256 "26cbd55cdc1d925f034e3eeb5c839a84c354e5536672018f22285e9b6979f65e"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1077/nuon-lsp_linux_arm64"
      sha256 "4f077103ec674535186f5f016b88fc5ca0e7b7ce3afc11ba27d47a33b27ba662"
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

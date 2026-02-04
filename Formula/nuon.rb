class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.766"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.766/nuon_darwin_amd64"
    sha256 "dfe94e5e2c21a0426a77809562ae4a47808a7ec99daf5270d893a9deaace157d"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.766/nuon_darwin_arm64"
    sha256 "8f5502eb72abb9a5c3a90886b578999f173e94e7e6efe5df6c34f6c7ec316a15"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.766/nuon_linux_amd64"
    sha256 "c759e041bf441d5bbf707db652e1c4d620a70879f2eb7acc22daa08af13594d3"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.766/nuon_linux_arm"
    sha256 "726885a7c356a0e6bc71ba6aaee0d60b6c4c4041b0be944bed575d4c32216a15"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.766/nuon_linux_arm64"
    sha256 "0526e0c19fa24a097f7bacfaacdecc8f18ad99c391a337c370b296f3340abce4"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.766/nuon-lsp_darwin_amd64"
      sha256 "d768e62610cc768683a6e622399ab7a83b294a981504a237ebc9d06aa065aaab"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.766/nuon-lsp_darwin_arm64"
      sha256 "76769f218f7fa582fd7baeb87e372c5240b477c7b1c0aee91d1213f260fd5cc2"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.766/nuon-lsp_linux_amd64"
      sha256 "3a11f6642eec0d87ef4b4e0caab7d1dd1ce5892552c15151457e02b0ebf4e9cc"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.766/nuon-lsp_linux_arm"
      sha256 "af5ed4dd3d9d35927bd76e91a1b9b33f1648b336fd71d0cf75a9da8d1c62d985"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.766/nuon-lsp_linux_arm64"
      sha256 "20de48b2226f16f57b125079596aaaffee96c3001f2b0715dc0982faaff6b881"
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

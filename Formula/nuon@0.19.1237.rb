class NuonAT0191237 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1237"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1237/nuon_darwin_amd64"
    sha256 "674c4012dd54c6faa78fb97d730d9c916ffababa3c76cf87b8353ef2ced7ede3"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1237/nuon_darwin_arm64"
    sha256 "b5b3d55e4c8e00c52bbbfb1b9af75c04a3143d6ed4774cb55569e40da82ff50a"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1237/nuon_linux_amd64"
    sha256 "37c3c2424be716b38d2d72b5d68095682f3e8477ddb13c04bdc51b0bc0f5bf08"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1237/nuon_linux_arm"
    sha256 "b944c71266f26b2e10910983c3080f968f340f556d170d781d063a517aebd533"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1237/nuon_linux_arm64"
    sha256 "42a4b2e1760a631ac732810030bf39a1385e53fa68430ad2bb637acaaf95bf82"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1237/nuon-lsp_darwin_amd64"
      sha256 "79975ee4b852b6228499ecaa0eab46b15919bca62e293eb45a778c4e165b6ee6"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1237/nuon-lsp_darwin_arm64"
      sha256 "62b31650c9fda33ddd81c48d981ff3582e47119bacfa9fa79bd6005d1f0829ab"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1237/nuon-lsp_linux_amd64"
      sha256 "5bbf589e745d7ee66457a9143e551ec2c5c14a9d577677536bfc7d29cc4c124f"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1237/nuon-lsp_linux_arm"
      sha256 "bdc21dfa97ffa675d7ca201b6b557b2fb4262c4edb6353016a7c9007e75a7072"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1237/nuon-lsp_linux_arm64"
      sha256 "0362f17837f37f4613bd82c712cafe4aeafb071648cd576440f7029d2ccf8569"
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

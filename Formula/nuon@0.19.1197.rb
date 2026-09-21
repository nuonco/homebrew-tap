class NuonAT0191197 < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.1197"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1197/nuon_darwin_amd64"
    sha256 "425c4cbf8c32233a690029bfc4e98f9e06970ba992d01b3ffabe5f5440b88b97"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1197/nuon_darwin_arm64"
    sha256 "71356c95466cf3332665a0ab9d714f30991191c26d7956ae79ef2df8abcf1e85"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1197/nuon_linux_amd64"
    sha256 "41d63f2482a1ca3c5e05ab62c3d149ebfa19ba15935b4b9afc96af402bf93d14"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1197/nuon_linux_arm"
    sha256 "87be46bbdc27b51bfd936a87fee755b4c2e19d9ecae151ac1408ef105a95d723"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.1197/nuon_linux_arm64"
    sha256 "0262aa4fa46207bbb92c5dda04c50006d636198ac41ef8488a8135d9c42c3c11"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1197/nuon-lsp_darwin_amd64"
      sha256 "12296fea1031121f16d11e34ba4029c912d9086aa55ddbb663c779e06867fa70"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1197/nuon-lsp_darwin_arm64"
      sha256 "82f490366891d6d93e5eee0cdee29da3fab9c0b02de39ab288c1c2502915ce76"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1197/nuon-lsp_linux_amd64"
      sha256 "02b7e236c6638639f5c7614de8a8e878af3e125a9843528c91514a1f3a9807d7"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1197/nuon-lsp_linux_arm"
      sha256 "59f08f7e862b29fe4bf4082ab8c402b2689588b0bf2640ad37eb8e385250cb99"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.1197/nuon-lsp_linux_arm64"
      sha256 "7724fb579f0ae99b27edaf27efd6155d247326f0736feab30ee7b53691fb4092"
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

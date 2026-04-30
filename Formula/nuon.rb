class Nuon < Formula
  desc "CLI client for Nuon with Language Server Protocol support"
  homepage "https://www.nuon.co/"
  version "0.19.908"

  # CLI binary
  if OS.mac? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.908/nuon_darwin_amd64"
    sha256 "04e231f26a7a27a95e84091b05c46f507ec400cec7e68f95f7d8c320a003a212"
  end

  if OS.mac? && Hardware::CPU.arm?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.908/nuon_darwin_arm64"
    sha256 "caa794ba302b5e104fd6ead1bd35e18f9ecadf3ea64092e15506b9a880d82f8a"
  end

  if OS.linux? && Hardware::CPU.intel?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.908/nuon_linux_amd64"
    sha256 "0214f30e3ea52416640db311a80ec4d16787048edd767ff6e60334d05a4ab3d9"
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.908/nuon_linux_arm"
    sha256 "07111633465eac69016179a665599ee6f4e64a1f8c03912a04fbbe0d6835ce8a"
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/cli/0.19.908/nuon_linux_arm64"
    sha256 "71403b8b87bb43e5246e28d9f11a1f7ab8f379ce99c5395276b40d44f53b44e9"
  end

  # LSP binary (as a resource)
  if OS.mac? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.908/nuon-lsp_darwin_amd64"
      sha256 "1416724effea6e7b90ce68caf8cf8e658a66bc69b9ab2050ffef85590fb0c391"
    end
  end

  if OS.mac? && Hardware::CPU.arm?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.908/nuon-lsp_darwin_arm64"
      sha256 "924f05d55ecd2e1f5259e8a8b5dbc46f359f0415d9e29dfe31c8dc192cb5cf03"
    end
  end

  if OS.linux? && Hardware::CPU.intel?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.908/nuon-lsp_linux_amd64"
      sha256 "6db99398a8666c1540de33f3cb78fa81844023e06bdd378ad95b98f3b5bc240b"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && !Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.908/nuon-lsp_linux_arm"
      sha256 "669a33d3e7190efe8f2e1e3f8b7c090389a1900b0e2957ad80283abb5fcf4ac6"
    end
  end

  if OS.linux? && Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
    resource "lsp" do
      url "https://nuon-artifacts.s3.us-west-2.amazonaws.com/lsp/0.19.908/nuon-lsp_linux_arm64"
      sha256 "24c8b34cbd5755e159c8e0a91ecaf3a4041d86aba88c988dda77613f326abb15"
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

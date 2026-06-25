class VpnUp < Formula
  desc "Secure command-line client for Cisco AnyConnect and other SSL VPNs"
  homepage "https://github.com/sorinipate/vpn-up-for-openconnect"
  url "https://github.com/sorinipate/vpn-up-for-openconnect/archive/refs/tags/v3.11.1.tar.gz"
  sha256 "e974b8706c6b03f71a9c5e04b323762251e80f8e8d2e2d38496f82ea5e762edf"
  license "MIT"

  depends_on "bash"
  depends_on "openconnect"
  depends_on "xmlstarlet"

  def install
    libexec.install Dir["*"]
    (bin/"vpn-up").write <<~SH
      #!/bin/sh
      exec "#{Formula["bash"].opt_bin}/bash" "#{opt_libexec}/vpn-up.command" "$@"
    SH
    chmod 0755, bin/"vpn-up"
    bash_completion.install libexec/"completions/vpn-up.bash" => "vpn-up"
  end

  test do
    assert_match "Usage:", shell_output(bin/"vpn-up")
  end
end

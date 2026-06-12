class VpnUp < Formula
  desc "Secure command-line client for Cisco AnyConnect and other SSL VPNs"
  homepage "https://github.com/sorinipate/vpn-up-for-openconnect"
  url "https://github.com/sorinipate/vpn-up-for-openconnect/archive/refs/tags/v3.4.0.tar.gz"
  sha256 "8c9897d2765bb4fc31261863793071a4047787ab1b5f3b3506d5207f60eb0f4a"
  license "MIT"

  depends_on "bash"
  depends_on "openconnect"
  depends_on "xmlstarlet"

  def install
    libexec.install Dir["*"]
    (bin/"vpn-up").write <<~SH
      #!/bin/sh
      exec "#{Formula["bash"].opt_bin}/bash" "#{libexec}/vpn-up.command" "$@"
    SH
    chmod 0755, bin/"vpn-up"
    bash_completion.install libexec/"completions/vpn-up.bash" => "vpn-up"
  end

  test do
    assert_match "Usage:", shell_output("#{bin}/vpn-up")
  end
end

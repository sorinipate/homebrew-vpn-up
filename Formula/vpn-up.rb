class VpnUp < Formula
  desc "Secure command-line client for Cisco AnyConnect and other SSL VPNs"
  homepage "https://github.com/sorinipate/vpn-up-for-openconnect"
  url "https://github.com/sorinipate/vpn-up-for-openconnect/archive/refs/tags/v3.9.1.tar.gz"
  sha256 "faa0697a46999cf90a94e8e1c62f0fd4590248d9ffefde50f7c53dd93f5491ea"
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

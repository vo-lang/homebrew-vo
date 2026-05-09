class Vo < Formula
  desc "Programming language compiler, runtime, and package manager"
  homepage "https://github.com/vo-lang/volang"

  release_version = "0.1.3"
  os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"
  arch = Hardware::CPU.arm? ? "aarch64" : "x86_64"
  target = "#{arch}-#{os}"
  sha256_by_target = {
    "aarch64-apple-darwin"      => "b98c9143e5acd2fe575ef0ecb79244f0d81d9acd3a726db9aeebb7400aa215b7",
    "x86_64-apple-darwin"       => "298ff50b40b5ed2ba815f234d863cb71c11bf9daae53a3d0c70e8cb1f5f625fb",
    "x86_64-unknown-linux-gnu"  => "96ef5ff0f5f5ad5248b78ca2a08d3b1c79180314d8894687cd333e6f7cb6179c",
    "aarch64-unknown-linux-gnu" => "20301cdf425a83be57421faca5323835c8864288c1b3a19b3d2c72cbb1afb008",
  }

  url "https://github.com/vo-lang/volang/releases/download/v#{release_version}/vo-#{target}.tar.gz"
  sha256 sha256_by_target.fetch(target)
  license "MIT"

  def install
    bin.install "vo"
  end

  test do
    version_output = shell_output("#{bin}/vo version")
    assert_match "vo version", version_output
    assert_match "v#{version}", version_output
    (testpath/"hello.vo").write <<~VO
      package main

      func main() {
        println("Hello, Vo!")
      }
    VO
    assert_match "Hello, Vo!", shell_output("#{bin}/vo run hello.vo")
  end
end

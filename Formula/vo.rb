class Vo < Formula
  desc "The Vo programming language - compiler, runtime, and package manager"
  homepage "https://github.com/vo-lang/volang"
  version "0.1.3"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/vo-lang/volang/releases/download/v#{version}/vo-aarch64-apple-darwin.tar.gz"
      sha256 "b98c9143e5acd2fe575ef0ecb79244f0d81d9acd3a726db9aeebb7400aa215b7"
    end
    on_intel do
      url "https://github.com/vo-lang/volang/releases/download/v#{version}/vo-x86_64-apple-darwin.tar.gz"
      sha256 "298ff50b40b5ed2ba815f234d863cb71c11bf9daae53a3d0c70e8cb1f5f625fb"
    end
  end

  on_linux do
    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/vo-lang/volang/releases/download/v#{version}/vo-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "20301cdf425a83be57421faca5323835c8864288c1b3a19b3d2c72cbb1afb008"
      end
    end
    on_intel do
      url "https://github.com/vo-lang/volang/releases/download/v#{version}/vo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "96ef5ff0f5f5ad5248b78ca2a08d3b1c79180314d8894687cd333e6f7cb6179c"
    end
  end

  def install
    bin.install "vo"
  end

  test do
    assert_match "vo version #{version}", shell_output("#{bin}/vo version")
    (testpath/"hello.vo").write <<~VO
      package main

      func main() {
        println("Hello, Vo!")
      }
    VO
    assert_match "Hello, Vo!", shell_output("#{bin}/vo run hello.vo")
  end
end

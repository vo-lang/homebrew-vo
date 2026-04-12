class Vo < Formula
  desc "The Vo programming language - compiler, runtime, and package manager"
  homepage "https://github.com/vo-lang/volang"
  version "0.1.2"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/vo-lang/volang/releases/download/v#{version}/vo-aarch64-apple-darwin.tar.gz"
      sha256 "7d685b7ba6b8e2650a17847b6a09a8c1c2d6587ad2c9616016b62842a8065175"
    end
    on_intel do
      url "https://github.com/vo-lang/volang/releases/download/v#{version}/vo-x86_64-apple-darwin.tar.gz"
      sha256 "7e9b2314f3b529cdc4d96f94a1705e1c683c461b81f128253c0043c960430779"
    end
  end

  on_linux do
    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/vo-lang/volang/releases/download/v#{version}/vo-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "b27ee9cd20eb2e971fb0401c63eea2f8b58cc349cd8a2f7eb2b4ae4480a788ae"
      end
    end
    on_intel do
      url "https://github.com/vo-lang/volang/releases/download/v#{version}/vo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "d3ca13541dec45c6e3a36437ec35c87e243285bbf2409a05eb41b998f1ed3aa9"
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

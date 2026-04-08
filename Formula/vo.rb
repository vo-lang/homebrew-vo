class Vo < Formula
  desc "The Vo programming language - compiler, runtime, and package manager"
  homepage "https://github.com/vo-lang/volang"
  version "0.1.0"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/vo-lang/volang/releases/download/v#{version}/vo-aarch64-apple-darwin.tar.gz"
      sha256 "PLACEHOLDER_AARCH64_APPLE_DARWIN"
    end
    on_intel do
      url "https://github.com/vo-lang/volang/releases/download/v#{version}/vo-x86_64-apple-darwin.tar.gz"
      sha256 "PLACEHOLDER_X86_64_APPLE_DARWIN"
    end
  end

  on_linux do
    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/vo-lang/volang/releases/download/v#{version}/vo-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "PLACEHOLDER_AARCH64_UNKNOWN_LINUX_GNU"
      end
    end
    on_intel do
      url "https://github.com/vo-lang/volang/releases/download/v#{version}/vo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "PLACEHOLDER_X86_64_UNKNOWN_LINUX_GNU"
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

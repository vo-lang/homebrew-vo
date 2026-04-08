class Vo < Formula
  desc "The Vo programming language - compiler, runtime, and package manager"
  homepage "https://github.com/vo-lang/volang"
  version "0.1.1"
  license "MIT"

  on_macos do
    on_arm do
      url "https://github.com/vo-lang/volang/releases/download/v#{version}/vo-aarch64-apple-darwin.tar.gz"
      sha256 "5d7780ed0a5d3d7a776cc69f082fe89532ac1dab2a1bc5da9c8a73b2833521b5"
    end
    on_intel do
      url "https://github.com/vo-lang/volang/releases/download/v#{version}/vo-x86_64-apple-darwin.tar.gz"
      sha256 "e698656cda89e1b9774e0e285f1ea6a558329af13bc712d15578794a9eedf1d0"
    end
  end

  on_linux do
    on_arm do
      if Hardware::CPU.is_64_bit?
        url "https://github.com/vo-lang/volang/releases/download/v#{version}/vo-aarch64-unknown-linux-gnu.tar.gz"
        sha256 "bfbc98ff7c4d76a6dd0b088a6f36f556bc2eb1b08955ecf7b4b8ca8510cfa0e0"
      end
    end
    on_intel do
      url "https://github.com/vo-lang/volang/releases/download/v#{version}/vo-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "fec2478fddb55b1a33af8e267ea79f676dff65edb01bdea87eb49582ab958fa9"
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

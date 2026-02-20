# Maintainer: Christopher Sieh (stelzo) <stelzo@steado.de>
# Template file — CI replaces 0.5.3 and b76f929fbeb88bf5be7929f29281abdac0a40875d94f09787dcbba209d1f4420 before publishing to the tap.
class Minot < Formula
  desc "A versatile toolset for debugging and verifying stateful robot perception software"
  homepage "https://github.com/uos/minot"
  version "0.5.3"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/uos/minot/releases/download/v#{version}/minot-aarch64-apple-darwin.tar.gz"
      sha256 "b76f929fbeb88bf5be7929f29281abdac0a40875d94f09787dcbba209d1f4420"
    end
  end

  def install
    bin.install "rat/minot"
    bin.install "minot-coord"
    bin.install "wind-rat"

    lib.install "librat.a"
    lib.install "librat.dylib"
    include.install "rat.h"

    generate_completions_from_executable(bin/"minot", "completions")
  end

  test do
    system "#{bin}/minot", "--version"
    system "#{bin}/minot-coord", "--version"
  end
end

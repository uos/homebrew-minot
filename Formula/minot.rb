# Maintainer: Christopher Sieh (stelzo) <stelzo@steado.de>
# Template file — CI replaces 0.6.0 and 95b917f3300ba13bd269879d006c78ec452bb4b028195bd7e1010b5d09b3a6c4 before publishing to the tap.
class Minot < Formula
  desc "A versatile toolset for debugging and verifying stateful robot perception software"
  homepage "https://github.com/uos/minot"
  version "0.6.0"
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/uos/minot/releases/download/v#{version}/minot-aarch64-apple-darwin.tar.gz"
      sha256 "95b917f3300ba13bd269879d006c78ec452bb4b028195bd7e1010b5d09b3a6c4"
    end
  end

  def install
    bin.install "rat/minot"
    bin.install "minot-coord"
    bin.install "wind-rat"

    lib.install "librat.a"
    lib.install "librat.dylib"
    (include/"rat").install "rat.h"

    inreplace "librat.pc", "prefix=/usr", "prefix=#{prefix}"
    (lib/"pkgconfig").install "librat.pc"
    (lib/"cmake/minot").install "libratConfig.cmake"

    # Fix install name for dylib to use @rpath
    system "install_name_tool", "-id", "@rpath/librat.dylib", lib/"librat.dylib"

    generate_completions_from_executable(bin/"minot", "completions")
  end

  test do
    system "#{bin}/minot", "--version"
    system "#{bin}/minot-coord", "--version"
  end
end

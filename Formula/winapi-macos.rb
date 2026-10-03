class WinapiMacos < Formula
  desc "Run educational WinAPI graphics projects natively on macOS"
  homepage "https://github.com/kwtpub/winapi-macos"
  url "https://github.com/kwtpub/winapi-macos/releases/download/v0.2.0/winapi-macos-0.2.0-universal-macos.tar.gz"
  sha256 "27b7239c6534fb662bbac6af8ad855cde74e5f63f32ab5fe29eafe5201a2d446"
  license "MIT"

  depends_on :macos

  def install
    bin.install "winapi-macos"
  end

  def caveats
    <<~EOS
      In your C++ project directory, run:
        winapi-macos
        g++ -std=c++17 main.cpp -I mac-native mac-native/libwinapi_macos.a -framework Cocoa -o app
        ./app

      Or install, build and run with a script:
        winapi-macos --run

      Building practice projects requires Xcode or Command Line Tools:
        xcode-select --install
    EOS
  end

  test do
    assert_equal "winapi-macos #{version}\n", shell_output("#{bin}/winapi-macos --version")
    source = <<~CPP
      #include <windows.h>
      static_assert(sizeof(COLORREF) == 4, "Windows color type");
      int main() {
        return RGB(255, 0, 0) == 255 &&
          SetPixel(nullptr, 0, 0, RGB(0, 0, 0)) == CLR_INVALID ? 0 : 1;
      }
    CPP
    (testpath/"main.cpp").write source
    system bin/"winapi-macos"
    assert_equal source, (testpath/"main.cpp").read
    assert_path_exists testpath/"mac-native/windows.h"
    assert_path_exists testpath/"mac-native/libwinapi_macos.a"
    assert_path_exists testpath/"mac-native/LICENSE"
    # Homebrew's CPATH can point to a different SDK than the selected xcrun SDK.
    ENV.delete "CPATH"
    system ENV.cxx, "-std=c++17", testpath/"main.cpp", "-I", testpath/"mac-native",
           testpath/"mac-native/libwinapi_macos.a", "-framework", "Cocoa", "-o", testpath/"app"
    system testpath/"app"
  end
end

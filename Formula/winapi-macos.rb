class WinapiMacos < Formula
  desc "Run educational WinAPI graphics projects natively on macOS"
  homepage "https://github.com/kwtpub/winapi-macos"
  url "https://github.com/kwtpub/winapi-macos/releases/download/v0.3.0/winapi-macos-0.3.0-universal-macos.tar.gz"
  sha256 "cc7da822e7b7adc668b9932fff54a6b22c9e7c278e2ee0b43f2696a543434d25"
  license "MIT"

  depends_on :macos

  def install
    bin.install "winapi-macos"
  end

  def caveats
    <<~EOS
      Set up compiler commands once, then open a new Terminal tab:
        winapi-macos --setup

      In your C++ project directory:
        winapi-macos
        g++ *.cpp -o app
        ./app

      Undo the shell setup with: winapi-macos --unsetup

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
    # Use an isolated shell configuration, preserving the real user's profiles.
    config = testpath/"shell-config"
    ENV["WINAPI_MACOS_CONFIG_HOME"] = config.to_s
    ENV["SHELL"] = "/bin/zsh"
    system bin/"winapi-macos", "--setup"
    ENV.prepend_path "PATH", config/".winapi-macos/bin"
    system File.basename(ENV.cxx), testpath/"main.cpp", "-o", testpath/"app"
    system testpath/"app"
    system bin/"winapi-macos", "--unsetup"
    refute_path_exists config/".zshrc"
    refute_path_exists config/".winapi-macos/bin/g++"
  end
end

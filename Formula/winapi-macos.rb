class WinapiMacos < Formula
  desc "Run educational WinAPI graphics projects natively on macOS"
  homepage "https://github.com/kwtpub/winapi-macos"
  url "https://github.com/kwtpub/winapi-macos/releases/download/v0.1.0/winapi-macos-0.1.0-universal-macos.tar.gz"
  sha256 "da43e52ac29a74f047c1d93fb463ea38bd848a8e4e32bdbae6b6913bfa2d78a5"
  license "MIT"

  depends_on :macos

  def install
    bin.install "winapi-macos"
  end

  def caveats
    <<~EOS
      In your C++ project directory, run:
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
      int main() { return RGB(255, 0, 0) == 255 ? 0 : 1; }
    CPP
    (testpath/"main.cpp").write source
    system bin/"winapi-macos"
    assert_equal source, (testpath/"main.cpp").read
    assert_path_exists testpath/"mac-native/windows.h"
    assert_path_exists testpath/"mac-native/LICENSE"
    system "/bin/bash", testpath/"mac-native/build.sh"
    system testpath/"mac-native/#{testpath.basename}_native"
  end
end

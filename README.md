# Homebrew tap for winapi-macos

```sh
brew install kwtpub/tap/winapi-macos
```

Затем в папке учебного C++-проекта:

```sh
winapi-macos
g++ -std=c++17 main.cpp -I mac-native mac-native/libwinapi_macos.a -framework Cocoa -o app
./app
```

Установщик добавляет заголовок `windows.h` и готовую библиотеку WinAPI/GDI
для Apple Silicon и Intel. Укажите в команде `g++` все исходники одной
программы. На macOS системный `g++` использует Apple Clang;
для сборки практик нужны Xcode или Command Line Tools.
Автоматическая сборка и запуск также доступны: `winapi-macos --run`.

Исходники и документация: [kwtpub/winapi-macos](https://github.com/kwtpub/winapi-macos).

## Updating a release

Publish a new version in the source repository, then update the formula URL
and SHA-256 to the published universal tar.gz from that release. Run
`brew style`, `brew audit --strict` and `brew test` before pushing.
Published release assets are kept immutable so the formula checksum stays valid.

License: [MIT](LICENSE).

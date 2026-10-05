# Homebrew tap for winapi-macos

```sh
brew install kwtpub/tap/winapi-macos
winapi-macos --setup
```

Откройте новую вкладку Terminal. Затем в папке учебного C++-проекта:

```sh
winapi-macos
g++ *.cpp -o app
./app
```

Установщик добавляет заголовок `windows.h` и готовую библиотеку WinAPI/GDI
для Apple Silicon и Intel. Однократный `--setup` настраивает zsh/bash:
команды компилятора сами подключают модуль в соответствующих проектах.
Если в папке несколько `main()`, укажите файлы одной программы.
На macOS системный `g++` использует Apple Clang;
для сборки практик нужны Xcode или Command Line Tools.
Автоматическая сборка и запуск также доступны: `winapi-macos --run`.
Отмена настройки терминала: `winapi-macos --unsetup` и новая вкладка Terminal.

Исходники и документация: [kwtpub/winapi-macos](https://github.com/kwtpub/winapi-macos).

## Updating a release

Publish a new version in the source repository, then update the formula URL
and SHA-256 to the published universal tar.gz from that release. Run
`brew style`, `brew audit --strict` and `brew test` before pushing.
Published release assets are kept immutable so the formula checksum stays valid.

License: [MIT](LICENSE).

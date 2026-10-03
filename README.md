# Homebrew tap for winapi-macos

```sh
brew install kwtpub/tap/winapi-macos
```

Затем в папке учебного C++-проекта:

```sh
winapi-macos --run
```

Команда добавляет переносную прослойку WinAPI/GDI, собирает и запускает
программу на macOS. Для сборки практик нужны Xcode Command Line Tools.

Исходники и документация: [kwtpub/winapi-macos](https://github.com/kwtpub/winapi-macos).

## Updating a release

Publish a new version in the source repository, then update the formula URL
and SHA-256 to the published universal tar.gz from that release. Run
`brew style`, `brew audit --strict` and `brew test` before pushing.
Published release assets are kept immutable so the formula checksum stays valid.

License: [MIT](LICENSE).

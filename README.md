# Malinkaos

[![CI](https://github.com/cezarygh/malinkaos/actions/workflows/ci.yml/badge.svg)](https://github.com/cezarygh/malinkaos/actions/workflows/ci.yml)

A cross-platform Flutter app for keeping track of projects, built as a learning project. It runs on **mobile** (iOS, Android) and **desktop** (macOS, Windows, Linux) from a single codebase.

## Features

- **Responsive navigation**: a bottom navigation bar on phones and a side navigation rail on wider screens (the switch happens at 600 px).
- **Dashboard**: summary cards that rearrange into 1, 2 or 3 columns depending on the available width.
- **Projects**: a list of projects loaded through an API layer (currently mock data, ready to be swapped for a database).
- **Settings**: grouped settings and app info.
- Light and dark theme that follows the device setting.

## Tech

- [Flutter](https://flutter.dev) and Dart, using only built-in widgets (no third-party packages yet)
- Widget tests with `flutter_test`
- Continuous integration with GitHub Actions (format check, analyze, tests)

## Project structure

The code is organised by **feature**. Each feature has the same layout:

```
lib/
  main.dart                 # entry point
  app.dart                  # MaterialApp and theme
  shared/                   # theme, breakpoints, responsive navigation shell
  features/
    <feature>/
      api/                  # where the feature gets and saves data
      data/                 # models (only for features that use data)
      presentation/
        <feature>_screen.dart
        widgets/            # widgets used only by this feature
```

Current features: `dashboard`, `projects`, `settings`.

## Getting started

Requires the [Flutter SDK](https://docs.flutter.dev/get-started/install).

```bash
git clone https://github.com/cezarygh/malinkaos.git
cd malinkaos
flutter pub get
flutter run -d macos      # or: ios, android, windows, linux
```

Run the checks:

```bash
flutter analyze
flutter test
```

## Roadmap

- [ ] Connect projects to a database
- [ ] Create, edit and delete projects
- [ ] Settings that can be changed and saved
- [ ] Dashboard numbers based on real data

## Contributing and versioning

Work happens on branches and is merged into `main` through pull requests. Versions follow [semantic versioning](https://semver.org) and are listed in [CHANGELOG.md](CHANGELOG.md). See [docs/git-workflow.md](docs/git-workflow.md) for the full workflow.

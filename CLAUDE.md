# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Purpose and working style

`malinkaos` is a **learning project**. The user is learning Flutter, and the app will connect to a database later. When you change code:
- Explain what you did and why, including any Flutter concept that is new in the code.
- Keep the syntax basic and readable: plain classes, `if`/`switch`, one widget per file. Avoid clever abstractions.
- Use only built-in Flutter widgets. Discuss with the user before adding any package (routing, state management, database, etc.).
- Keep the short explanatory comments that introduce Flutter concepts (e.g. why `IndexedStack`, what `FutureBuilder` does).

The app targets mobile (iOS/Android) and desktop (macOS/Windows/Linux). Web is scaffolded but not a focus.

## Commands

```bash
flutter pub get                      # install dependencies
flutter run -d macos                 # run (other devices: ios, android, windows, linux, chrome)
flutter analyze                      # lint (flutter_lints, see analysis_options.yaml)
dart format lib test                 # format (CI runs it with --set-exit-if-changed)
flutter test                         # run all tests
flutter test test/widget_test.dart   # run a single test file
flutter test --plain-name "mobile"   # run tests whose name contains "mobile"
```

## Folder rules

```
lib/
  main.dart          # only runApp(const App())
  app.dart           # MaterialApp, theme, home: AppShell
  shared/            # code used by more than one feature (theme, breakpoints, navigation)
  features/
    <feature>/
      api/           # always present: where the feature gets/saves data (.gitkeep if empty)
      data/          # only for features that use data: model classes
      presentation/
        <feature>_screen.dart   # the page, e.g. projects_screen.dart
        widgets/                # widgets used only by this feature
```

- Every feature follows this layout, including features added later. Name files in `snake_case`.
- A widget used by more than one feature moves to `lib/shared/`.
- Features don't import each other's files. Only `shared/navigation/app_shell.dart` imports the screens.

## Architecture

- **Navigation and responsiveness** (`lib/shared/navigation/app_shell.dart`): `AppShell` is a `StatefulWidget` that holds `_selectedIndex`. The pages are listed in the `destinations` list (`NavDestination` objects), and both navigation widgets are built from that one list, so adding a page means adding one entry there. If the screen is narrower than `mobileBreakpoint` (600, defined in `shared/layout/breakpoints.dart`), it shows a bottom `NavigationBar`. Otherwise it shows a `NavigationRail` on the left. Pages live in an `IndexedStack`, so they keep their state when you switch pages.
- **Responsive pages**: when a screen needs to adapt, use `LayoutBuilder` to get the width it actually has, and use `mobileBreakpoint` and `desktopBreakpoint` from `shared/layout/breakpoints.dart` for the thresholds. (The pages are empty placeholders for now.)
- **Data flow** (planned, not built yet): a feature's `api/` class returns a `Future` of model objects from `data/`. The screen stores the Future in `initState` (never calls it inside `build`) and renders loading, error, empty and list states with a `FutureBuilder`. **The database will plug in here:** only the api class body should change, and screens and models stay the same.
- **Theme** (`lib/shared/theme/app_theme.dart`): light and dark `ThemeData` are both generated from one seed color, and the app uses `ThemeMode.system`. Read colors and text styles through `Theme.of(context)` instead of hardcoding them.
- **Tests** (`test/widget_test.dart`): these set the test screen size to check both the mobile and the desktop layout, and they tap through all pages. Tap navigation items by icon, because each label also appears in the page's app bar and body.

## Conventions

- Linting uses `package:flutter_lints/flutter.yaml` with no custom rules. The analyzer excludes `build/` and the platform folders.

## Git workflow

The full guide is in `docs/git-workflow.md`. The remote is `github.com/cezarygh/malinkaos`, and the repo is public.
- There are two permanent branches, and neither is ever deleted. `main` holds tagged releases only. `develop` is the integration branch. Don't commit directly to either.
- Branch off `develop` using `feat/<name>`, `fix/<name>`, `docs/<name>`, `refactor/<name>` or `chore/<name>`, then open a pull request **into `develop`**.
- A release is a pull request from `develop` into `main`, merged with a merge commit (not squash), then tagged on `main`. Hotfixes branch off `main` and are merged back into `develop` afterwards.
- Use Conventional Commits (`feat:`, `fix:`, `docs:`, `refactor:`, `test:`, `chore:`).
- CI (`.github/workflows/ci.yml`) runs the format check, analyze and tests on pushes to `main` and `develop` and on pull requests. Run the same checks locally before committing.
- Add user-facing changes to `## [Unreleased]` in `CHANGELOG.md`. For a release: move them into a version section, bump `version:` in `pubspec.yaml` (semver, and increase the `+build` number), then tag `vX.Y.Z`.
- The repo-local git identity is the GitHub noreply address. Don't change it.

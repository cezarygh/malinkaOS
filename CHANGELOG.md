# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project follows [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Changed
- Dashboard, Projects and Settings are now empty placeholder pages; mock data and example widgets removed.

## [0.1.0] - 2026-09-30

### Added
- Responsive app shell: bottom navigation bar on mobile, navigation rail on desktop.
- Dashboard page with summary cards in a responsive grid.
- Projects page that loads mock projects through `ProjectsApi`.
- Settings page with grouped sections.
- Light and dark theme from a single seed color.
- Widget tests for the mobile and desktop layouts.
- GitHub Actions CI (format check, analyze, tests).

[Unreleased]: https://github.com/cezarygh/malinkaos/compare/v0.1.0...HEAD
[0.1.0]: https://github.com/cezarygh/malinkaos/releases/tag/v0.1.0

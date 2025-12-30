# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**Niyet (نية)** - A daily intention tracker app rooted in Islamic practice.
- **Tagline:** "Intentions before actions"
- **Core philosophy:** Track what you intended, not just what you did. Reflection matters more than completion.

## Terminology

- **niyet** (singular) - intention
- **niyetler** (plural) - intentions
- Use Turkish/Kazakh terminology, NOT Arabic (niyyah/niyyat)

## Architecture

Clean Architecture with BLoC state management pattern:

```
lib/src/
├── app/                    # App entry, flavor config
├── core/                   # Shared infrastructure
│   ├── base/               # UseCase, Result patterns
│   ├── db/                 # Drift database
│   ├── localization/       # i18n (en, ar, kk)
│   ├── router/             # GoRouter config
│   ├── services/           # Injectable DI setup
│   └── theme/              # Earth-toned theme
└── features/               # Feature modules
    ├── niyet/              # Core intention feature
    ├── calendar/           # Calendar view
    ├── home/               # Home screen
    └── settings/           # App settings
```

Each feature follows Clean Architecture layers:
- `domain/` - entities, repositories (abstract), usecases
- `data/` - datasources, models, repository implementations
- `presentation/` - bloc, pages, widgets

## Common Commands

```bash
# Get dependencies
flutter pub get

# Generate code (freezed, drift, injectable)
dart run build_runner build --delete-conflicting-outputs

# Watch mode for code generation
dart run build_runner watch --delete-conflicting-outputs

# Run the app (dev flavor)
flutter run

# Run prod flavor
flutter run -t lib/main_prod.dart

# Analyze code
flutter analyze

# Run tests
flutter test
```

## Key Patterns

### State Management (BLoC)
- Events: `part of` bloc file pattern
- States: Equatable with copyWith
- Real-time updates via Drift streams

### Dependency Injection
- GetIt + Injectable annotations
- `@lazySingleton` for services
- `@injectable` for BLoCs

### Database (Drift)
- Local SQLite via Drift ORM
- Table: `Niyetler` (plural of niyet)
- Streams for reactive UI updates
- Schema version: 2 (migrated from `niyyat` to `niyetler`)
- Use `DROP TABLE IF EXISTS` for safe migrations

### Result Type
```dart
@Freezed(toJson: false, fromJson: false)
sealed class Result<T> with _$Result<T> {
  const factory Result.success(T data) = Success<T>;
  const factory Result.failure(Exception exception) = Failure<T>;
}
```

## Data Model

```dart
class Niyet {
  final String id;
  final DateTime date;
  final String text;
  final NiyetCategory category;  // ibadah, akhlaq, family, charity, work
  final NiyetOutcome? outcome;   // fulfilled, tried, missed
  final String? reflection;
  final bool forAllah;
  final DateTime createdAt;
}
```

## Localization

ARB files in `lib/src/core/localization/intl/`:
- `app_en.arb` - English
- `app_ar.arb` - Arabic
- `app_kk.arb` - Kazakh

## Theme

Earth-toned, minimalist design:
- Primary: Sage Green (#6B8E6B)
- Secondary: Warm Sand (#D4B896)
- Accent: Soft Gold (#D4A574)
- No gamification elements

## Workflow Rules

### Git & PRs
- **NO** "Generated with Claude Code" footer in commits or PRs
- **NO** "Co-Authored-By: Claude" lines in commits
- **NO** emojis in commits/PRs unless user requests
- PR workflow: create PR -> review -> fix issues -> merge when user approves
- Use `superpowers:code-reviewer` for reviews before merging

### Code Review Process
1. Create feature branch
2. Push and create PR
3. Run code review via subagent
4. Fix any Critical/Important issues
5. Wait for user approval
6. Merge to main

## Performance Patterns

### BLoC State
- Cache computed properties in state constructor
- Avoid recalculating `.where()` on every access
```dart
NiyetState({...})
  : reflectedCount = niyetler.where((n) => n.isReflected).length,
    unreflectedCount = niyetler.where((n) => !n.isReflected).length;
```

### Theme Lookups
- Cache `Theme.of(context)` at start of build method
- Avoid repeated lookups in widget tree

### Keyboard Dismiss
- Wrap Scaffold in GestureDetector with `FocusScope.of(context).unfocus()`

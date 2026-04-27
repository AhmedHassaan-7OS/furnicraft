# FurniCraft — Agent Rules (AI-Friendly)

This repository is a Flutter app (Dart SDK `^3.11.4`) using:
- State management: `flutter_bloc` (Cubits + explicit State classes)
- Navigation: `go_router` with centralized routes
- UI style constants: `AppColors`, `AppSpacing`, `AppTextStyles` under `lib/core/util/constants/`

These rules are written to work with **any AI agent** (Cursor, Copilot, Claude, etc.).

## Non-negotiables

- **Be minimal & local**: prefer small, targeted changes over broad refactors.
- **Don’t change dependencies / SDK constraints** in `pubspec.yaml` unless explicitly requested.
- **Don’t rename routes or change route paths** without updating all call sites and documenting migration notes.
- **Don’t change Cubit state shapes** (state class names/fields/meaning) without updating all UI selectors and flows.
- **Keep code analyzable**: no dead code, no unused imports, no ignore directives unless there is a strong reason.

## Project map (where things go)

- **Entry point**: `lib/main.dart` (wires `MultiBlocProvider`, theme, and `MaterialApp.router`)
- **Routing**: `lib/core/router/app_router.dart`
- **Core/shared**: `lib/core/**` (router, constants, utilities)
- **Features**: `lib/features/<feature>/`
  - `cubit/` → Cubit + states (e.g. `auth_cubit.dart`, `auth_states.dart`)
  - `ui/` → `screens/`, `sections/`, `widgets/`

## Dart & Flutter conventions

- **Naming**
  - Files/folders: `snake_case` (already used in this repo)
  - Types/classes/enums: `PascalCase`
  - Methods/fields/locals: `lowerCamelCase`
- **Prefer `const` widgets** whenever possible to reduce rebuild cost.
- **No side-effects in `build()`**. Trigger loading in `initState()` (as done in `CategoryScreen`) or via user actions.
- **Keep widgets small**: extract reusable pieces into `ui/widgets/` and screen sections into `ui/sections/`.
- **Use the existing design system**: prefer `AppColors` / `AppSpacing` / `AppTextStyles` instead of ad-hoc values.
- **Imports**
  - Prefer relative imports within `lib/` as already used (keep style consistent within touched files).
  - Keep imports sorted and remove unused ones.

## State management (Cubit) rules

This repo uses a simple “Cubit + explicit state classes” style.

- **Where logic lives**
  - UI widgets should be thin; business/state transitions live in Cubits.
  - Don’t put async work inside widgets except calling Cubit methods.
- **State design**
  - Prefer immutable state objects (use `final` fields; provide `copyWith` where appropriate).
  - Emit a new state for each meaningful transition (loading → loaded, filter changed, etc.).
  - Avoid storing mutable collections in state unless carefully controlled.
- **UI integration**
  - Use `BlocBuilder` (or `BlocListener` when reacting with one-off effects like snackbars/navigation).
  - When selecting derived values from different states, keep the selector logic simple and readable.

## Navigation (GoRouter) rules

- **Add/modify routes only in** `lib/core/router/app_router.dart`.
- If a screen needs parameters, pass them explicitly (currently `state.extra` is used).
- Keep route strings centralized (use `AppRoutes.*`) and avoid hardcoding paths elsewhere.

## Safe editing checklist (for agents)

When you change code, aim to run:

- `flutter format .`
- `flutter analyze`
- `flutter test`

If you can’t run commands, at least ensure:
- No obvious analyzer issues (unused imports/vars, missing `const`, type mismatches)
- No broken imports after renames/moves

## Changes that require extra care

- **Editing `lib/main.dart`**: can affect app-wide DI, theme, routing.
- **Editing `app_router.dart`**: can break navigation across the whole app.
- **Editing constants** under `lib/core/util/constants/`: can affect global UI consistency.

## How to write changes (expected output)

- Provide a brief summary of *why* the change is needed.
- Mention affected files.
- Keep diffs readable and consistent with existing project style.


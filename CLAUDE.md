# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

```bash
# Development
flutter pub get
flutter run --dart-define-from-file=.env.json

# Analysis & testing
flutter analyze
flutter test

# Build
flutter build apk --release
flutter build appbundle --release
flutter build ios --release
```

Copy `.env.json.example` to `.env.json` and fill in the required credentials before running.

## Architecture

This is a Flutter health/wellness app for veterans ("Endurance") built with GetX state management and GoRouter navigation.

### Entry point & initialization

`lib/main.dart` registers all GetX controllers and configures GoRouter. Controllers are singletons accessible via `Get.find<T>()` throughout the app.

### Navigation

`lib/app/router.dart` uses GoRouter with a `ChangeNotifier` bridge (`RouterNotifier`) that listens to `AuthController` and triggers redirects. A `MainShell` wraps the four bottom-tab routes (Home, Chats, Network, Profile). Route guards in `lib/app/route_guard.dart` enforce veteran-only and authenticated-only access.

### State management pattern

Each feature follows a layered pattern:
- **Model** (`*_model.dart`) — plain Dart data class
- **Service** (`*_service.dart`) — API calls via `ApiClient` (Dio)
- **Controller** (`*_controller.dart`) — GetX `GetxController` holding `Rx` state, calls service, exposes methods to UI

Key controllers: `AuthController`, `UserController`, `ChatController`, `NetworkController`, `DailyCheckInController`, `NotificationController`, `QuoteController`.

### API client

`lib/core/api_client.dart` builds a Dio instance with two interceptors:
- `_AuthInterceptor` — attaches Bearer token from `AuthController`, handles 401 by refreshing the Keycloak token and retrying
- `_EmptyBodyInterceptor` — handles 204 empty responses

Environment config (API base URL, Keycloak settings) is injected at compile time via `--dart-define-from-file` and read from `lib/core/app_config.dart`.

### Core infrastructure

`lib/core/` contains cross-cutting infrastructure:
- `api_client.dart` — Dio instance factory with auth and error interceptors
- `app_config.dart` — compile-time environment constants (`AppConfig`)

### Authentication

OAuth2/OIDC via Keycloak using `flutter_appauth`. Tokens stored in `flutter_secure_storage`. The "veteran" role gates access to the main features — `AuthController.isVeteran` is checked by route guards.

### Real-time messaging

`WebSocketService` maintains a persistent WebSocket connection. `ChatController` subscribes to it and updates `Rx` conversation/message state reactively.

### Localization

Uses `flutter_intl`. Source strings live in `lib/l10n/`, generated output in `lib/generated/`. Access strings via `S.of(context).key` in widgets. Always add new strings to the l10n files and regenerate — never hardcode UI text.

### Health data

`lib/services/health/health_service.dart` integrates with the `health` package for reading wearable/device health samples (used for stress and mood data).

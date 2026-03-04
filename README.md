# Countries App

Flutter mobile app to browse, search, and view country details using the REST Countries API.

## Features

- Home list of countries (flag, name, population)
- Search countries by name (debounced)
- Country details screen (flag, key stats, timezone)
- Favorites with local persistence
- Light/Dark/System theme toggle
- Pull to refresh
- Sort by default/name/population

🏗 Technology & Architecture Choices

This project was built with scalability, performance, and clean architecture in mind.

🔄 State Management — BLoC (over Cubit)

I chose BLoC instead of Cubit because it provides a more structured and event-driven approach.
It clearly separates events, business logic, and states, making the app easier to scale, debug, and maintain as features grow.

🌐 Networking — Dio (over http)

I used Dio instead of the standard http package because it provides:

Better error handling

Interceptors support

Request/response configuration

Easy integration with caching

This makes the networking layer more production-ready and extensible.

💾 Local Storage — Hive (over SharedPreferences)

I selected Hive instead of shared_preferences because:

It supports storing full objects (not just primitive values)

It is fast and lightweight

It scales better for future offline support

Hive is used to persist favorite countries locally.

🧪 Testing — Mocktail (over Mockito)

I used Mocktail instead of Mockito due to version conflicts with newer Dart versions.

Mocktail:

Supports null-safety

Does not require code generation

Is simple and lightweight

It was used together with bloc_test for testing BLoC logic.

🧩 Dependency Injection — get_it

get_it was used to manage dependencies in a clean way.
This improves testability and keeps the code modular and organized.

🏛 Architecture

The app follows a clean and modular structure with separation of concerns:

Presentation Layer (UI + BLoC)

Data Layer (API + Local Storage)

Models (immutable and type-safe)

This structure makes the project scalable, maintainable, and easy to extend.

## API

Base URL: `https://restcountries.com/v3.1`

- List all countries: `/all?fields=name,flags,population,cca2`
- Search countries: `/name/{name}?fields=name,flags,population,cca2`
- Country details: `/alpha/{code}?fields=name,flags,population,capital,region,subregion,area,timezones`

Favorites flow:

- Persist only `cca2` locally.
- Resolve favorite cards from country details (`/alpha/{code}`), including capital.

## Run Locally

1. Install Flutter SDK (stable) and run `flutter doctor`.
2. Install dependencies:
   ```bash
   flutter pub get
   ```
3. Run the app:
   ```bash
   flutter run
   ```

## Build APK

```bash
flutter build apk --release
```

Output APK path:
`build/app/outputs/flutter-apk/app-release.apk`

# 📱 Stack Overflow Users App

A Flutter app to browse Stack Overflow users, view their reputation history, and manage bookmarks.
Built with **Clean Architecture**, offline caching, and responsive UI.

---

## 🚀 Demo Links

* **Repository:** [GitHub Repo](https://github.com/ElsayedDev/stackoverflow_users_app)
* **Android APK:** [Releases](https://github.com/ElsayedDev/stackoverflow_users_app/releases)
* **🎥 Video Demo:** [Watch Demo Video](https://drive.google.com/file/d/148k2cE0qQDVERnsN9YCvAEYgXFA8rjLe/view?usp=drivesdk)

---

## ✨ Features

* **Browse Users:** Top Stack Overflow users with infinite scroll (sorted by reputation).
* **User Profiles:** Avatar, display name, reputation, badge counts (gold/silver/bronze).
* **Reputation History:** Paginated timeline with direct links to Stack Overflow posts.
* **Smart Bookmarking:**
  - Toggle bookmarks with optimistic UI updates
  - Confirmation dialog before removing bookmarks
  - Success/removal feedback via SnackBars
  - Dedicated "Bookmarked" tab with paginated loading (20 users/page)
  - Real-time sync across All/Bookmarked tabs
* **Offline-First:** Hive caches user pages & reputation history for seamless offline browsing.
* **Responsive UI:** Adaptive layouts for phones, tablets, portrait & landscape.
* **Error Handling:** Empty states, retry buttons, pull-to-refresh, inline error snackbars.
* **Localization:** i18n ready with English ARB (extendable to more locales).

---

## 🛠 Architecture & Stack

### Architecture
* **Clean Architecture** with clear separation:
  - **Data Layer:** Remote/local data sources, repositories, models (Freezed), mappers
  - **Domain Layer:** Entities, repository contracts, use cases
  - **Presentation Layer:** Cubits (BLoC pattern), UI models, screens/widgets
* **Patterns:**
  - `PaginatedFetchMixin`: Reusable pagination logic with request deduplication
  - Repository pattern with Either<Failure, T> error handling (dartz)
  - Optimistic updates for instant UI feedback

### Tech Stack
* **State Management:** `flutter_bloc` (Cubit) + `get_it` (dependency injection)
* **Networking:** `dio` with custom interceptor for Stack Exchange API key
* **Caching:** `hive` + `hive_flutter` for offline-first persistence
* **Code Generation:** 
  - `freezed` + `json_serializable` for immutable models
  - `build_runner` for code generation
  - `flutter_gen_runner` for type-safe asset references
* **UI/UX:** 
  - `flutter_screenutil` for responsive sizing
  - `cached_network_image` for avatar caching
  - `flutter_svg` for vector icons
  - `html_unescape` for Stack Overflow content decoding
* **Utilities:** 
  - `dartz` for functional error handling
  - `rxdart` for reactive streams
  - `intl` + `flutter_localizations` for i18n
  - `flutter_dotenv` for environment config
  - `url_launcher` for opening Stack Overflow posts

---

## 📂 Project Structure

```
lib/
  core/            # bootstrap, di, network, theme, utils, widgets
  features/
    users/         # data / domain / presentation
  generated/       # intl generated files
  l10n/            # localization arb files
  main.dart        # entry point
  my_app.dart      # app widget
test/              # unit & widget tests
integration_test/  # integration tests with Patrol
assets/            # icons, colors
```

---

## ⚡ Setup

### Prerequisites

* Flutter 3.24+ and Dart 3.6+
* Stack Apps API key

### Installation

```bash
git clone https://github.com/ElsayedDev/stackoverflow_users_app.git
cd stackoverflow_users_app
flutter pub get
```

### Environment

Create `.env` in project root:

```
STACK_EXCHANGE_KEY=your_stack_apps_key
```

👉 For review, a demo key is included (not for production).

### Run

```bash
flutter run -d <device>
```

### Build

* Android: `flutter build apk --release`
* iOS: `flutter build ipa`
* Web: `flutter build web`

### Codegen

```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## 🧪 Testing Strategy

This project maintains **comprehensive test coverage** across multiple layers to ensure reliability and maintainability.

### Test Structure

```
test/
├── features/users/
│   ├── data/           # Repository & data source tests
│   ├── domain/         # Use case tests
│   └── presentation/   # Cubit & widget tests
├── helpers/            # Test fakes & builders
└── widget_test.dart    # App-level smoke test

integration_test/       # End-to-end Patrol tests
```

### Testing Layers & Focus

#### 🔵 Unit Tests

**Domain Layer** (`test/features/users/domain/usecases_test.dart`)
- ✅ Use case delegation to repository
- ✅ Parameter handling (GetUsers, GetReputation, ToggleBookmark)
- ✅ Stream-based bookmark watching
- ✅ Short-circuit logic for empty ID lists

**Data Layer** (`test/features/users/data/users_repository_impl_test.dart`)
- ✅ Remote data fetching with caching
- ✅ Offline fallback from Hive cache
- ✅ Bookmark persistence & stream emission
- ✅ getUserById with cache hits/misses

**State Management** (`test/features/users/presentation/cubits_test.dart`)
- ✅ **UsersCubit**: first page load, pagination, bookmark stream integration
- ✅ **BookmarksCubit**: bookmark stream reactions, paginated user loading by IDs
- ✅ **ReputationCubit**: user profile fetch, reputation history pagination

#### 🟢 Widget Tests

**Views** (`test/features/users/presentation/views/`)
- ✅ **HomeView**: renders header, tabs, handles tab switching
- ✅ **UsersTab**: displays user list, handles empty/error states
- ✅ **BookmarkedUsersTab**: shows bookmarked users, empty state messaging
- ✅ **UserReputationPage**: profile header, reputation list rendering

**Focus Areas:**
- UI element presence (titles, lists, empty states)
- Tab navigation and filter switching
- Pull-to-refresh interactions
- Error/loading state rendering

#### 🟣 Integration Tests (Patrol)

**End-to-End Flows** (`integration_test/`)
- ✅ **Home View**: full app navigation, tab switching, data loading
- ✅ **Users Tab**: scroll, bookmark toggle, visual feedback
- ✅ **Bookmarked Tab**: add/remove flow, confirmation dialogs, snackbars
- ✅ **Reputation View**: profile display, reputation history, post links

**What's Tested:**
- Real navigation flows between screens
- User interactions (tap, scroll, pull-to-refresh)
- Bookmark confirmation dialogs & success messages
- Responsive layout switching (portrait/landscape)
- Offline-first behavior with mock repository

### Test Packages & Tools

| Package | Purpose | Used In |
|---------|---------|---------|
| `flutter_test` | Core testing framework | All test layers |
| `bloc_test` | Cubit/Bloc testing utilities | State management tests |
| `mocktail` | Mock objects for dependencies | Repository & use case tests |
| `patrol` | Native integration testing with real gestures | End-to-end flows |

### Running Tests

**All Tests:**
```bash
flutter test
```

**Specific Test File:**
```bash
flutter test test/features/users/presentation/cubits_test.dart
```

**Integration Tests (requires device/emulator):**
```bash
# All Patrol tests
dart run patrol test

# Single integration test
dart run patrol test integration_test/home_view_it_test.dart
```

**With Coverage:**
```bash
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

### Test Helpers

**Mock Repository** (`test/features/users/data/mock_users_repository.dart`)
- Deterministic fake data (120 users, reputation history)
- In-memory bookmark storage
- Configurable delays for async testing

**Test Fakes** (`test/helpers/fakes.dart`)
- `StubUsersRepository`: minimal stub for quick tests
- `FakeUsersLocalDataSource`: in-memory Hive simulation
- `FakeUsersRemoteDataSource`: controlled API responses
- Entity/model builders for test data construction

### Coverage Goals

- ✅ **Use Cases**: 100% (all delegate correctly)
- ✅ **Repository**: Core flows covered (fetch, cache, bookmarks)
- ✅ **Cubits**: State transitions & pagination logic
- ✅ **Views**: Key user journeys & error states
- ✅ **Integration**: Critical paths (browse → bookmark → reputation)

### CI/CD Integration

Ready for automated testing pipeline:
```yaml
# Example GitHub Actions workflow
- flutter analyze          # Lint & static analysis
- flutter test --coverage  # Unit & widget tests with coverage
- dart run patrol test     # Integration tests (on tagged releases)
```

> **Note:** CI workflow not yet configured. See `.github/workflows/` for setup templates.

---

## 📌 Notes

* **`.env` Security:** Committed only for review purposes → must be `.gitignore`d in production.
* **Offline-First:** Hive stores user pages & reputation history; app works seamlessly offline after initial data load.
* **Error Handling:** Comprehensive UX with snackbars, empty states, retry buttons, and pull-to-refresh.
* **Bookmark UX:** Confirmation dialog before un-bookmarking; success/removal feedback via SnackBars.
* **Responsive Design:** Adaptive layouts for portrait and landscape on phones & tablets.
* **Optimistic Updates:** Bookmark toggles update UI immediately, rolling back only on failure.
* **Stream Synchronization:** Real-time bookmark state synced across All/Bookmarked tabs via RxDart streams.

---

## 🔮 Future Improvements

* **Testing & CI:**
  - Set up GitHub Actions workflow for automated testing
  - Add unit tests for widget-level bookmark feedback
  - Expand integration test coverage for error scenarios
* **UI/UX Enhancements:**
  - Dark theme support with theme switcher
  - Skeleton loaders during initial fetch
  - Enhanced accessibility (screen readers, semantic labels)
  - Advanced filters (location, badges, reputation range)
  - **Connectivity awareness:** show “No internet” banner and gracefully fallback to cached data
* **Localization:**
  - Add more locales (Arabic, Spanish, etc.)
  - Runtime language switching without restart
* **Performance:**
  - Smarter cache invalidation strategies
  - Image optimization and progressive loading
  - Background sync for bookmarks
* **DevOps:**
  - Automated release pipelines (APK/TestFlight/Web)
  - Crashlytics/Firebase Analytics integration
  - A/B testing infrastructure

---

## 👤 Author

* Ahmed Elsayed
* [LinkedIn](https://www.linkedin.com/in/elsayeddev/)
* [GitHub](https://github.com/elsayeddev)

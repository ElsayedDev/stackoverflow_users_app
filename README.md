# 📱 Stack Overflow Users App

A Flutter app to browse Stack Overflow users, view their reputation history, and manage bookmarks.
Built with **Clean Architecture**, offline caching, and responsive UI.

---

## 🚀 Demo Links

* **Repository:** [GitHub Repo](https://github.com/ElsayedDev/stackoverflow_users_app)
* **Android APK:** [Releases](https://github.com/ElsayedDev/stackoverflow_users_app/releases)
* **Video Demo:** [Watch Demo Video]

---

## ✨ Features

* Browse top Stack Overflow users with infinite scroll (by reputation).
* View user profile header: avatar, display name, reputation, badge counts.
* Open reputation history with direct links to posts.
* Bookmark users with one tap → dedicated Bookmarked tab with pagination.
* Pull-to-refresh, error/empty state handling with snackbars.
* Offline-first: Hive caches user and reputation pages.
* Responsive UI for phones & tablets.
* Localization-ready (English ARB included).

---

## 🛠 Architecture & Stack

* **Architecture:** Clean Architecture → `data` → `domain` → `presentation`.
* **State management:** `flutter_bloc` (Cubit) + `get_it` (DI).
* **Networking:** `dio` + interceptor to append Stack Exchange API key.
* **Caching:** `hive`, `hive_flutter`.
* **Codegen:** `freezed`, `json_serializable`, `build_runner`.
* **Utilities:** `dartz`, `rxdart`, `cached_network_image`, `intl`, `flutter_dotenv`, `flutter_screenutil`.

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

## 🧪 Testing

* Unit & widget tests:

```bash
flutter test
```

* Integration tests (Patrol):

```bash
dart run patrol test
```

---

## 📌 Notes

* `.env` is committed only for review → in production it must be ignored.
* Offline-first caching: Hive stores user pages & reputations.
* Error handling: snackbars + empty/error state views.
* Confirmatio for Un-bookmarking.
* Reponsive for portrait and landscape options.

---

## 🔮 Future Improvements

* Expand test coverage + CI.
* Add dark theme, skeleton loaders, accessibility.
* More locales with runtime language switching.
* Smarter cache invalidation.
* Automated release pipelines (APK/TestFlight/Web).

---

## 👤 Author

* Ahmed Elsayed
* [LinkedIn](https://www.linkedin.com/in/elsayeddev/)
* [GitHub](https://github.com/elsayeddev)

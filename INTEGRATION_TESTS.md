Patrol integration tests

Prerequisites
- A device/simulator running.
- Packages installed (flutter pub get).

Run locally
- Patrol runner (recommended):
  - dart run patrol test
  - To run a single test file:
    - dart run patrol test integration_test/home_view_it_test.dart
    - dart run patrol test integration_test/users_tab_it_test.dart
    - dart run patrol test integration_test/bookmarked_users_tab_it_test.dart
    - dart run patrol test integration_test/user_reputation_view_it_test.dart

- Flutter test runner is NOT supported for Patrol tests and will fail with a binding conflict (IntegrationTestWidgetsFlutterBinding vs PatrolBinding). Use the Patrol runner above.

Notes
- Tests use the app's MyApp widget and rely on mock-free startup. If your app requires DI overrides, wire them in main() or provide a custom entry.
- Make sure patrol.yaml has correct identifiers:
  - Android package_name should match android/app/build.gradle defaultConfig.applicationId (currently com.example.stackoverflow_users_app).
  - iOS bundle_id should match Runner target's Product Bundle Identifier in Xcode (currently com.example.stackoverflowUsersApp).

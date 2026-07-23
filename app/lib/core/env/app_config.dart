/// Runtime config. `BASE_URL` is injected at build time via `--dart-define`.
/// Default targets the Android emulator host loopback (10.0.2.2) for local dev;
/// override for iOS simulator (http://localhost:3000) or the hosted backend.
abstract final class AppConfig {
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://10.0.2.2:3000',
  );

  static const String apiPrefix = '/api/v1';
}

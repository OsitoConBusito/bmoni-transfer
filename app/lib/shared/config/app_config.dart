abstract final class AppConfig {
  // Android emulator host loopback by default; override via --dart-define.
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: 'http://10.0.2.2:3000',
  );

  static const String apiPrefix = '/api/v1';
}

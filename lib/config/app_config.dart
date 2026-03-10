/// Compile-time environment configuration.
///
/// Values are injected via `--dart-define` (or `--dart-define-from-file`)
/// at build/run time. Example:
///
///   flutter run \
///     --dart-define=KEYCLOAK_ISSUER=https://10.0.2.2:8443/realms/endurance \
///     --dart-define=KEYCLOAK_CLIENT_ID=mobile \
///     --dart-define=KEYCLOAK_REDIRECT_URI=be.kdg.endurance://oauthredirect \
///     --dart-define=WEB_APP_URL=https://endurance.kdg.be
///
/// Or with a JSON file (recommended):
///
///   flutter run --dart-define-from-file=.env.json
///
/// See `.env.json.example` for the expected file format.
class AppConfig {
  AppConfig._();

  static const keycloakIssuer = String.fromEnvironment(
    'KEYCLOAK_ISSUER',
    defaultValue: 'https://127.0.0.1:8443/realms/endurance',
  );

  static const keycloakClientId = String.fromEnvironment(
    'KEYCLOAK_CLIENT_ID',
    defaultValue: 'mobile',
  );

  static const keycloakRedirectUri = String.fromEnvironment(
    'KEYCLOAK_REDIRECT_URI',
    defaultValue: 'be.kdg.endurance://oauthredirect',
  );

  static const webAppUrl = String.fromEnvironment(
    'WEB_APP_URL',
    defaultValue: 'https://endurance.kdg.be',
  );

  static const apiBaseUrl = String.fromEnvironment(
    'API_BASE_URL',
    defaultValue: 'http://localhost:8080',
  );
}

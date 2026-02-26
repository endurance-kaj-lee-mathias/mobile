import 'dart:convert';

/// Holds the tokens returned by the OAuth token exchange.
class TokenModel {
  final String accessToken;
  final String? refreshToken;
  final String? idToken;
  final DateTime? accessTokenExpirationDateTime;

  TokenModel({
    required this.accessToken,
    this.refreshToken,
    this.idToken,
    this.accessTokenExpirationDateTime,
  });

  /// Decodes the JWT access token and returns the user's realm-level roles
  /// from Keycloak's `realm_access.roles` claim.
  List<String> get realmRoles {
    try {
      final parts = accessToken.split('.');
      if (parts.length != 3) return [];

      var payload = parts[1];
      switch (payload.length % 4) {
        case 2:
          payload += '==';
        case 3:
          payload += '=';
      }

      final data =
          jsonDecode(utf8.decode(base64Url.decode(payload)))
              as Map<String, dynamic>;
      return ((data['realm_access'] as Map<String, dynamic>?)?['roles']
                  as List<dynamic>?)
              ?.cast<String>() ??
          [];
    } catch (_) {
      return [];
    }
  }
}

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

  Map<String, dynamic> get _payload {
    try {
      final parts = accessToken.split('.');
      if (parts.length != 3) return {};
      var p = parts[1];
      switch (p.length % 4) {
        case 2:
          p += '==';
        case 3:
          p += '=';
      }
      return jsonDecode(utf8.decode(base64Url.decode(p)))
          as Map<String, dynamic>;
    } catch (_) {
      return {};
    }
  }

  /// Decodes the JWT access token and returns the user's realm-level roles
  /// from Keycloak's `realm_access.roles` claim.
  List<String> get realmRoles {
    try {
      return ((_payload['realm_access'] as Map<String, dynamic>?)?['roles']
                  as List<dynamic>?)
              ?.cast<String>() ??
          [];
    } catch (_) {
      return [];
    }
  }

  /// Email from the JWT `email` claim.
  String? get email => _payload['email']?.toString();

  /// Phone number from the JWT — Keycloak uses the `phone_number` claim.
  String? get phoneNumber =>
      (_payload['phone_number'] ?? _payload['phoneNumber'])?.toString();
}

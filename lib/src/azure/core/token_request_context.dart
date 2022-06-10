import 'dart:core';

class TokenRequestContext {
  final List<String> _scopes;
  final String? _parentRequestId;
  final String? _claims;
  final String? _tenantId;

  /// <summary>
  /// The scopes required for the token.
  /// </summary>
  List<String> get scopes => _scopes;

  /// <summary>
  /// The <see cref="P:Azure.Core.Request.ClientRequestId" /> of the request requiring a token for authentication, if applicable.
  /// </summary>
  String? get parentRequestId => _parentRequestId;

  /// <summary>
  /// Additional claims to be included in the token. See <see href="https://openid.net/specs/openid-connect-core-1_0-final.html#ClaimsParameter">https://openid.net/specs/openid-connect-core-1_0-final.html#ClaimsParameter</see> for more information on format and content.
  /// </summary>
  String? get claims => _claims;

  /// <summary>
  /// The tenantId to be included in the token request.
  /// </summary>
  String? get tenantId => _tenantId;

  TokenRequestContext(
      {required List<String> scopes,
      String? parentRequestId,
      String? claims,
      String? tenantId})
      : _scopes = scopes,
        _parentRequestId = parentRequestId,
        _claims = claims,
        _tenantId = tenantId;
}

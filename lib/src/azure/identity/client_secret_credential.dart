import 'dart:core';
import 'package:http/http.dart' as http;
import '../core/token_credential.dart';
import '../core/access_token.dart';
import '../core/token_request_context.dart';
import 'validations.dart';

class ClientSecretCredential extends TokenCredential {
  final String _tenantId;
  final String _clientId;
  final String _clientSecret;

  /// <summary>
  /// Gets the Azure Active Directory tenant (directory) Id of the service principal
  /// </summary>
  String? get tenantId => _tenantId;

  /// <summary>
  /// Gets the client (application) ID of the service principal
  /// </summary>
  String? get clientId => _clientId;

  /// <summary>
  /// Gets the client secret that was generated for the App Registration used to authenticate the client.
  /// </summary>
  String? get clientSecret => _clientSecret;

  ClientSecretCredential(
      {required String tenantId,
      required String clientId,
      required String clientSecret,
      TokenCredentialOptions options,
      CredentialPipeline pipeline,
      MsalConfidentialClient client})
      : _tenantId = validateTenantId(tenantId, "tenantId"),
        _clientId = clientId,
        _clientSecret = clientSecret;

  //ClientSecretCredential.clientSecretCredentialOptions({required String tenantId, required String clientId, required String clientSecret, ClientSecretCredentialOptions options})

  @override
  Future<AccessToken> getTokenAsync(TokenRequestContext requestContext) async {
    final resp = await http.get(Uri.parse(''));
    return AccessToken(token: "qsqds", expiresOn: DateTime.now());
  }

  @override
  AccessToken getToken(TokenRequestContext requestContext) {
    return AccessToken(token: 'token', expiresOn: DateTime.now());
  }
}

import 'access_token.dart';
import 'dart:async';
import 'token_request_context.dart';

abstract class TokenCredential {
  /// <summary>
  /// Gets an <see cref="T:Azure.Core.AccessToken" /> for the specified set of scopes.
  /// </summary>
  /// <param name="requestContext">The <see cref="T:Azure.Core.TokenRequestContext" /> with authentication information.</param>
  /// <returns>A valid <see cref="T:Azure.Core.AccessToken" />.</returns>
  /// <remarks>Caching and management of the lifespan for the <see cref="T:Azure.Core.AccessToken" /> is considered the responsibility of the caller: each call should request a fresh token being requested.</remarks>
  Future<AccessToken> getTokenAsync(TokenRequestContext requestContext);

  /// <summary>
  /// Gets an <see cref="T:Azure.Core.AccessToken" /> for the specified set of scopes.
  /// </summary>
  /// <param name="requestContext">The <see cref="T:Azure.Core.TokenRequestContext" /> with authentication information.</param>
  /// <returns>A valid <see cref="T:Azure.Core.AccessToken" />.</returns>
  /// <remarks>Caching and management of the lifespan for the <see cref="T:Azure.Core.AccessToken" /> is considered the responsibility of the caller: each call should request a fresh token being requested.</remarks>
  AccessToken getToken(TokenRequestContext requestContext);
}

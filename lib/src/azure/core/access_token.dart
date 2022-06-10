import 'dart:core';

class AccessToken {
  String token;
  DateTime expiresOn;

  AccessToken({
    required this.token,
    required this.expiresOn,
  });
}

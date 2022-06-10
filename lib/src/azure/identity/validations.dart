import 'dart:core';
import '../core/exceptions.dart';

const String _invalidTenantIdErrorMessage =
    "Invalid tenant id provided. You can locate your tenant id by following the instructions listed here: https://docs.microsoft.com/partner-center/find-ids-and-domain-names";

// const String _nullTenantIdErrorMessage =
//     "Tenant id cannot be null. You can locate your tenant id by following the instructions listed here: https://docs.microsoft.com/partner-center/find-ids-and-domain-names";

// const String _nonTlsAuthorityHostErrorMessage =
//     "Authority host must be a TLS protected (https) endpoint.";

// const String _noWindowsPowerShellLegacyErrorMessage =
//     "PowerShell Legacy is only supported in Windows.";

bool isValidTenantCharacter(var c) {
  return (c >= 'a' && c <= 'z') ||
      (c >= 'A' && c <= 'Z') ||
      (c >= '0' && c <= '9') ||
      (c == '.') ||
      (c == '-');
}

String validateTenantId(String tenantId, [String argumentName = "", bool allowEmpty = false]) {
  for (int i = 0; i < tenantId.length; i++) {
    if (!isValidTenantCharacter(tenantId[i])) {
      throw (argumentName.isNotEmpty)
          ? ArgumentException(_invalidTenantIdErrorMessage, argumentName)
          : ArgumentException(_invalidTenantIdErrorMessage);
    }
  }

  return tenantId;
}

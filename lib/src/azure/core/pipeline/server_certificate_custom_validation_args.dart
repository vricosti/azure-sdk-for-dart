import 'dart:io';
//import 'package:x509b/x509.dart' as X509Chain;

class X509Chain {}

abstract class SslPolicyErrors {
  static int noErrorPolicy = 0;

  static int remoteCertificateNotAvailable = 1;

  static int remoteCertificateNameMismatch = 2;

  static int remoteCertificateChainErrors = 4;
}

class ServerCertificateCustomValidationArgs {
  /// <summary>
  /// The certificate used to authenticate the remote party.
  /// </summary>
  final X509Certificate? _certificate;
  X509Certificate? get certificate => _certificate;

  /// <summary>
  /// The chain of certificate authorities associated with the remote certificate.
  /// </summary>
  final X509Chain? _certificateAuthorityChain;
  X509Chain? get certificateAuthorityChain => _certificateAuthorityChain;

  /// <summary>
  /// One or more errors associated with the remote certificate.
  /// </summary>
  final SslPolicyErrors? _sslPolicyErrors;
  SslPolicyErrors? get sslPolicyErrors => _sslPolicyErrors;

  /// <summary>
  /// Initializes an instance of <see cref="ServerCertificateCustomValidationArgs"/>.
  /// </summary>
  /// <param name="certificate">The certificate</param>
  /// <param name="certificateAuthorityChain"></param>
  /// <param name="sslPolicyErrors"></param>
  ServerCertificateCustomValidationArgs(X509Certificate? certificate,
      X509Chain? certificateAuthorityChain, SslPolicyErrors sslPolicyErrors)
      : _certificate = certificate,
        _certificateAuthorityChain = certificateAuthorityChain,
        _sslPolicyErrors = sslPolicyErrors;
}

import './server_certificate_custom_validation_args.dart';

class HttpPipelineTransportOptions {
  /// <summary>
  /// A delegate that validates the certificate presented by the server.
  /// </summary>
  ///
  bool Function(ServerCertificateCustomValidationArgs)? serverCertificateCustomValidationCallback;
}

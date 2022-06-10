import 'dart:core';
import 'environment.dart';
import 'exceptions.dart';
import 'client_options.dart';

class DiagnosticsOptions {
  static const maxApplicationIdLength = 24;

  /// <summary>
  /// Creates a new instance of <see cref="DiagnosticsOptions"/> with default values.
  /// </summary>
  // DiagnosticsOptions() : this(ClientOptions.Default.Diagnostics)
  // { }

  /// <summary>
  /// Initializes the newly created <see cref="DiagnosticsOptions"/> with the same settings as the specified <paramref name="diagnosticsOptions"/>.
  /// </summary>
  /// <param name="diagnosticsOptions">The <see cref="DiagnosticsOptions"/> to model the newly created instance on.</param>
  DiagnosticsOptions(DiagnosticsOptions? aDiagnosticsOptions) {
    if (aDiagnosticsOptions != null) {
      applicationId = aDiagnosticsOptions.applicationId;
      isLoggingEnabled = aDiagnosticsOptions.isLoggingEnabled;
      isTelemetryEnabled = aDiagnosticsOptions.isTelemetryEnabled;
      loggedHeaderNames = aDiagnosticsOptions.loggedHeaderNames;
      loggedQueryParameters = aDiagnosticsOptions.loggedQueryParameters;
      loggedContentSizeLimit = aDiagnosticsOptions.loggedContentSizeLimit;
      isDistributedTracingEnabled = aDiagnosticsOptions.isDistributedTracingEnabled;
      isLoggingContentEnabled = aDiagnosticsOptions.isLoggingContentEnabled;
    } else {
      loggedHeaderNames = [
        "x-ms-request-id",
        "x-ms-client-request-id",
        "x-ms-return-client-request-id",
        "traceparent",
        "MS-CV",
        "Accept",
        "Cache-Control",
        "Connection",
        "Content-Length",
        "Content-Type",
        "Date",
        "ETag",
        "Expires",
        "If-Match",
        "If-Modified-Since",
        "If-None-Match",
        "If-Unmodified-Since",
        "Last-Modified",
        "Pragma",
        "Request-Id",
        "Retry-After",
        "Server",
        "Transfer-Encoding",
        "User-Agent",
        "WWW-Authenticate" // OAuth Challenge header.
      ];
      loggedQueryParameters = ["api-version"];
      bool? disableTelemetry =
          environmentVariableToBool(Environment.getEnvironmentVariable("AZURE_TELEMETRY_DISABLED"));
      isTelemetryEnabled = disableTelemetry ?? true;
      bool? disableAzureTracing =
          environmentVariableToBool(Environment.getEnvironmentVariable("AZURE_TELEMETRY_DISABLED"));
      isDistributedTracingEnabled = disableAzureTracing ?? true;
    }
  }

  /// <summary>
  /// Get or sets value indicating whether HTTP pipeline logging is enabled.
  /// </summary>
  bool isLoggingEnabled = false;

  /// <summary>
  /// Gets or sets value indicating whether distributed tracing spans are going to be created for this clients methods calls and HTTP calls.
  /// </summary>
  bool isDistributedTracingEnabled = true;

  /// <summary>
  /// Gets or sets value indicating whether the "User-Agent" header containing <see cref="ApplicationId"/>, client library package name and version, <see cref="RuntimeInformation.FrameworkDescription"/>
  /// and <see cref="RuntimeInformation.OSDescription"/> should be sent.
  /// The default value can be controlled process wide by setting <c>AZURE_TELEMETRY_DISABLED</c> to <c>true</c>, <c>false</c>, <c>1</c> or <c>0</c>.
  /// </summary>
  bool isTelemetryEnabled = false;

  /// <summary>
  /// Gets or sets value indicating if request or response content should be logged.
  /// </summary>
  bool isLoggingContentEnabled = false;

  /// <summary>
  /// Gets or sets value indicating maximum size of content to log in bytes. Defaults to 4096.
  /// </summary>
  int loggedContentSizeLimit = 4 * 1024;

  /// <summary>
  /// Gets a list of header names that are not redacted during logging.
  /// </summary>
  List<String> loggedHeaderNames = [];

  /// <summary>
  /// Gets a list of query parameter names that are not redacted during logging.
  /// </summary>
  List<String> loggedQueryParameters = [];

  /// <summary>
  /// Gets or sets the value sent as the first part of "User-Agent" headers for all requests issues by this client. Defaults to <see cref="DefaultApplicationId"/>.
  /// </summary>
  String? _applicationId;
  String? get applicationId {
    return _applicationId;
  }

  set applicationId(String? value) {
    if (value != null && value.length > maxApplicationIdLength) {
      throw ArgumentOutOfRangeException(
          "value", "applicationId must be shorter than ${maxApplicationIdLength + 1} characters");
    }
    _applicationId = value;
  }

  /// <summary>
  /// Gets or sets the default application id. Default application id would be set on all instances.
  /// </summary>
  static String? get defaultApplicationId => ClientOptions.defaultOptions.diagnostics.applicationId;
  static set defaultApplicationId(String? value) {
    ClientOptions.defaultOptions.diagnostics.applicationId = value;
  }

  static bool? environmentVariableToBool(String? value) {
    if (value == "true" || value == "1") {
      return true;
    }
    if (value == "false" || value == "0") {
      return false;
    }
    return null;
  }
}

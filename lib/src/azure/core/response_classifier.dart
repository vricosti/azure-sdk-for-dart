import 'dart:io';
import 'exceptions.dart';
import 'http_message.dart';

class ResponseClassifier {
  factory ResponseClassifier() {
    return ResponseClassifier();
  }

  /// <summary>
  /// Specifies if the request contained in the <paramref name="message"/> should be retried.
  /// </summary>
  bool isRetriableResponse(HttpMessage message) {
    switch (message.Response.Status) {
      case 408: // Request Timeout
      case 429: // Too Many Requests
      case 500: // Internal Server Error
      case 502: // Bad Gateway
      case 503: // Service Unavailable
      case 504: // Gateway Timeout
        return true;
      default:
        return false;
    }
  }

  /// <summary>
  /// Specifies if the operation that caused the exception should be retried.
  /// </summary>
  bool isRetriableException(Exception exception) {
    return (exception is IOException) ||
        (exception is RequestFailedException && (exception as RequestFailedException).status == 0);
  }

  /// <summary>
  /// Specifies if the operation that caused the exception should be retried taking the <see cref="HttpMessage"/> into consideration.
  /// </summary>
  bool isRetriable(HttpMessage message, Exception exception) {
    return isRetriableException(exception);
    // return isRetriableException(exception) ||
    //        // Retry non-user initiated cancellations
    //        (exception is OperationCanceledException && !message.CancellationToken.IsCancellationRequested);
  }

  /// <summary>
  /// Specifies if the response contained in the <paramref name="message"/> is not successful.
  /// </summary>
  bool isErrorResponse(HttpMessage message) {
    var statusKind = message.Response.Status / 100;
    return statusKind == 4 || statusKind == 5;
  }
}

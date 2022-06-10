import 'client_options.dart';
import 'retry_mode.dart';

class RetryOptions {
  /// <summary>
  /// Initializes the newly created <see cref="RetryOptions"/> with the same settings as the specified <paramref name="retryOptions"/>.
  /// </summary>
  /// <param name="retryOptions">The <see cref="RetryOptions"/> to model the newly created instance on.</param>
  RetryOptions(RetryOptions? retryOptions) {
    if (retryOptions == null) {
      maxRetries = ClientOptions.defaultOptions.retry.maxRetries;
      delay = ClientOptions.defaultOptions.retry.delay;
      maxDelay = ClientOptions.defaultOptions.retry.maxDelay;
      mode = ClientOptions.defaultOptions.retry.mode;
      networkTimeout = ClientOptions.defaultOptions.retry.networkTimeout;
    } else {
      maxRetries = retryOptions.maxRetries;
      delay = retryOptions.delay;
      maxDelay = retryOptions.maxDelay;
      mode = retryOptions.mode;
      networkTimeout = retryOptions.networkTimeout;
    }
  }

  /// <summary>
  /// The maximum number of retry attempts before giving up.
  /// </summary>
  int maxRetries = 3;

  /// <summary>
  /// The delay between retry attempts for a fixed approach or the delay
  /// on which to base calculations for a backoff-based approach.
  /// If the service provides a Retry-After response header, the next retry will be delayed by the duration specified by the header value.
  /// </summary>
  Duration delay = Duration(milliseconds: 800);

  /// <summary>
  /// The maximum permissible delay between retry attempts when the service does not provide a Retry-After response header.
  /// If the service provides a Retry-After response header, the next retry will be delayed by the duration specified by the header value.
  /// </summary>
  Duration maxDelay = Duration(minutes: 1);

  /// <summary>
  /// The approach to use for calculating retry delays.
  /// </summary>
  RetryMode mode = RetryMode.exponential;

  /// <summary>
  /// The timeout applied to an individual network operations.
  /// </summary>
  Duration networkTimeout = Duration(seconds: 100);
}

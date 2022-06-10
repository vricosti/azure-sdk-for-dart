enum RetryMode {
  /// <summary>
  /// Retry attempts happen at fixed intervals; each delay is a consistent duration.
  /// </summary>
  fixed,

  /// <summary>
  /// Retry attempts will delay based on a backoff strategy, where each attempt will increase
  /// the duration that it waits before retrying.
  /// </summary>
  exponential
}

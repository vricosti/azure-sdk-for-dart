import 'http_pipeline_transport_options.dart';

abstract class HttpPipelineTransport {
  /// <summary>
  /// Sends the request contained by the <paramref name="message"/> and sets the <see cref="HttpMessage.Response"/> property to received response synchronously.
  /// </summary>
  /// <param name="message">The <see cref="HttpMessage"/> containing request and response.</param>
  void process(HttpMessage message);

  /// <summary>
  /// Sends the request contained by the <paramref name="message"/> and sets the <see cref="HttpMessage.Response"/> property to received response asynchronously.
  /// </summary>
  /// <param name="message">The <see cref="HttpMessage"/> containing request and response.</param>
  ValueTask processAsync(HttpMessage message);

  /// <summary>
  /// Creates a new transport specific instance of <see cref="Request"/>. This should not be called directly, <see cref="HttpPipeline.CreateRequest"/> or
  /// <see cref="HttpPipeline.CreateMessage()"/> should be used instead.
  /// </summary>
  /// <returns></returns>
  Request createRequest();

  /// <summary>
  /// Creates the default <see cref="HttpPipelineTransport"/> based on the current environment and configuration.
  /// </summary>
  /// <param name="options"><see cref="HttpPipelineTransportOptions"/> that affect how the transport is configured.</param>
  /// <returns></returns>
  static HttpPipelineTransport create(HttpPipelineTransportOptions? options) {
    if (options == null) {
      return HttpClientTransport.shared;
    } else {
      return HttpClientTransport(options);
    }
  }
}

import '../http_message.dart';

abstract class HttpPipelinePolicy {
  /// <summary>
  /// Applies the policy to the <paramref name="message"/>. Implementers are expected to mutate <see cref="HttpMessage.Request"/> before calling <see cref="ProcessNextAsync"/> and observe the <see cref="HttpMessage.Response"/> changes after.
  /// </summary>
  /// <param name="message">The <see cref="HttpMessage"/> this policy would be applied to.</param>
  /// <param name="pipeline">The set of <see cref="HttpPipelinePolicy"/> to execute after current one.</param>
  /// <returns>The <see cref="ValueTask"/> representing the asynchronous operation.</returns>
  Future processAsync(HttpMessage message, List<HttpPipelinePolicy> pipeline);

  /// <summary>
  /// Applies the policy to the <paramref name="message"/>. Implementers are expected to mutate <see cref="HttpMessage.Request"/> before calling <see cref="ProcessNextAsync"/> and observe the <see cref="HttpMessage.Response"/> changes after.
  /// </summary>
  /// <param name="message">The <see cref="HttpMessage"/> this policy would be applied to.</param>
  /// <param name="pipeline">The set of <see cref="HttpPipelinePolicy"/> to execute after current one.</param>
  void process(HttpMessage message, List<HttpPipelinePolicy> pipeline);

  /// <summary>
  /// Invokes the next <see cref="HttpPipelinePolicy"/> in the <paramref name="pipeline"/>.
  /// </summary>
  /// <param name="message">The <see cref="HttpMessage"/> next policy would be applied to.</param>
  /// <param name="pipeline">The set of <see cref="HttpPipelinePolicy"/> to execute after next one.</param>
  /// <returns>The <see cref="ValueTask"/> representing the asynchronous operation.</returns>
  static Future processNextAsync(HttpMessage message, List<HttpPipelinePolicy> pipeline) {
    return pipeline[0].processAsync(message, pipeline.sublist(1));
  }

  /// <summary>
  /// Invokes the next <see cref="HttpPipelinePolicy"/> in the <paramref name="pipeline"/>.
  /// </summary>
  /// <param name="message">The <see cref="HttpMessage"/> next policy would be applied to.</param>
  /// <param name="pipeline">The set of <see cref="HttpPipelinePolicy"/> to execute after next one.</param>
  static void processNext(HttpMessage message, List<HttpPipelinePolicy> pipeline) {
    pipeline[0].process(message, pipeline.sublist(1));
  }
}

import 'dart:typed_data';
import 'http_header.dart';
import 'response_headers.dart';
import 'http_message_sanitizer.dart';

class BinaryData {}

abstract class Response {
  /// <summary>
  /// Gets the HTTP status code.
  /// </summary>
  final int _status = 0;
  int get status => _status;

  /// <summary>
  /// Gets the HTTP reason phrase.
  /// </summary>
  final String _reasonPhrase = "";
  String get reasonPhrase => _reasonPhrase;

  /// <summary>
  /// Gets the contents of HTTP response. Returns <c>null</c> for responses without content.
  /// </summary>
  Uint8List contentStream = Uint8List.fromList([]);

  /// <summary>
  /// Gets the client request id that was sent to the server as <c>x-ms-client-request-id</c> headers.
  /// </summary>
  String clientRequestId = "";

  /// <summary>
  /// Get the HTTP response headers.
  /// </summary>
  ResponseHeaders get headers => ResponseHeaders(this);

  // TODO(matell): The .NET Framework team plans to add BinaryData.Empty in dotnet/runtime#49670, and we can use it then.
  //static readonly BinaryData _s_EmptyBinaryData = BinaryData(Array.Empty<byte>());

  /// <summary>
  /// Gets the contents of HTTP response, if it is available.
  /// </summary>
  /// <remarks>
  /// Throws <see cref="InvalidOperationException"/> when <see cref="ContentStream"/> is not a <see cref="MemoryStream"/>.
  /// </remarks>
  BinaryData _content = BinaryData();
  BinaryData get content {
    return BinaryData();
    // if (ContentStream == null)
    // {
    //     return s_EmptyBinaryData;
    // }

    // MemoryStream? memoryContent = ContentStream as MemoryStream;

    // if (memoryContent == null)
    // {
    //     throw new InvalidOperationException($"The response is not fully buffered.");
    // }

    // if (memoryContent.TryGetBuffer(out ArraySegment<byte> segment))
    // {
    //     return new BinaryData(segment.AsMemory());
    // }
    // else
    // {
    //     return new BinaryData(memoryContent.ToArray());
    // }
    //}
  }

  /// <summary>
  /// Indicates whether the status code of the returned response is considered
  /// an error code.
  /// </summary>
  bool isError = false;

  HttpMessageSanitizer sanitizer = HttpMessageSanitizer.createDefault();

  /// <summary>
  /// Returns header value if the header is stored in the collection. If header has multiple values they are going to be joined with a comma.
  /// </summary>
  /// <param name="name">The header name.</param>
  /// <param name="value">The reference to populate with value.</param>
  /// <returns><c>true</c> if the specified header is stored in the collection, otherwise <c>false</c>.</returns>
  /*protected*/ String? tryGetHeader(String name);

  /// <summary>
  /// Returns header values if the header is stored in the collection.
  /// </summary>
  /// <param name="name">The header name.</param>
  /// <param name="values">The reference to populate with values.</param>
  /// <returns><c>true</c> if the specified header is stored in the collection, otherwise <c>false</c>.</returns>
  /*protected*/ Iterable<String>? tryGetHeaderValues(String name);

  /// <summary>
  /// Returns <c>true</c> if the header is stored in the collection.
  /// </summary>
  /// <param name="name">The header name.</param>
  /// <returns><c>true</c> if the specified header is stored in the collection, otherwise <c>false</c>.</returns>
  /*protected*/ bool containsHeader(String name);

  /// <summary>
  /// Returns an iterator for enumerating <see cref="HttpHeader"/> in the response.
  /// </summary>
  /// <returns>The <see cref="IEnumerable{T}"/> enumerating <see cref="HttpHeader"/> in the response.</returns>

  /*protected*/ Iterable<HttpHeader> enumerateHeaders() {
    return headers;
  }

  /// <summary>
  /// Creates a new instance of <see cref="Response{T}"/> with the provided value and HTTP response.
  /// </summary>
  /// <typeparam name="T">The type of the value.</typeparam>
  /// <param name="value">The value.</param>
  /// <param name="response">The HTTP response.</param>
  /// <returns>A new instance of <see cref="Response{T}"/> with the provided value and HTTP response.</returns>
  //     static Response<T> FromValue<T>(T value, Response response)
  //     {
  //         return ValueResponse<T>(response, value);
  //     }
}

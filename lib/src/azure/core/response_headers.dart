import 'dart:io';
import 'http_header.dart';
import 'response.dart';

class ResponseHeaders implements List<HttpHeader> {
  Response _response;

  ResponseHeaders(Response response) : _response = response;

  /// <summary>
  /// Gets the parsed value of "Date" or "x-ms-date" header.
  /// </summary>
  DateTime? get date {
    DateTime? date;
    var value = tryGetValue(HttpHeaderNames.date);
    if (value != null) {
      date = HttpDate.parse(value);
    } else {
      value = tryGetValue(HttpHeaderNames.xMsDate);
      if (value != null) {
        date = HttpDate.parse(value);
      }
    }
    return date;
  }

  /// <summary>
  /// Gets the value of "Content-Type" header.
  /// </summary>
  String? get contentType => tryGetValue(HttpHeaderNames.contentType);

  /// <summary>
  /// Gets the parsed value of "Content-Length" header.
  /// </summary>
  int? get contentLength {
    int? value;
    var strVal = tryGetValue(HttpHeaderNames.contentLength);
    if (strVal != null) {
      value = int.parse(strVal);
    }
    return value;
  }

  /// <summary>
  /// Gets the parsed value of "ETag" header.
  /// </summary>
  eTag? get eTag => tryGetValue(HttpHeaderNames.eTag) ? Azure.ETag.Parse(stringValue) : null;

  /// <summary>
  /// Gets the value of "x-ms-request-id" header.
  /// </summary>
  String? get requestId => tryGetValue(HttpHeaderNames.xMsRequestId);

  /// <summary>
  /// Returns an enumerator that iterates through the <see cref="ResponseHeaders"/>.
  /// </summary>
  /// <returns>A <see cref="IEnumerator{T}"/> for the <see cref="ResponseHeaders"/>.</returns>
  Iterable<HttpHeader> getEnumerator() {
    return _response.enumerateHeaders();
  }

  /// <summary>
  /// Returns header value if the header is stored in the collection. If header has multiple values they are going to be joined with a comma.
  /// </summary>
  /// <param name="name">The header name.</param>
  /// <param name="value">The reference to populate with value.</param>
  /// <returns><c>true</c> if the specified header is stored in the collection, otherwise <c>false</c>.</returns>
  String? tryGetValue(String name) {
    return _response.tryGetHeader(name);
  }

  /// <summary>
  /// Returns header values if the header is stored in the collection.
  /// </summary>
  /// <param name="name">The header name.</param>
  /// <param name="values">The reference to populate with values.</param>
  /// <returns><c>true</c> if the specified header is stored in the collection, otherwise <c>false</c>.</returns>
  Iterable<String>? tryGetValues(String name) {
    return _response.tryGetHeaderValues(name);
  }

  /// <summary>
  /// Returns <c>true</c> if the header is stored in the collection.
  /// </summary>
  /// <param name="name">The header name.</param>
  /// <returns><c>true</c> if the specified header is stored in the collection, otherwise <c>false</c>.</returns>
  @override
  bool contains(Object? name) {
    if (name == null) {
      return false;
    }
    return _response.containsHeader(name as String);
  }
}

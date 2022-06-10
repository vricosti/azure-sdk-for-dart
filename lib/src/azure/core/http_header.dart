import 'exceptions.dart';

class HttpHeader {
  /// <summary>
  /// Creates a new instance of <see cref="HttpHeader"/> with provided name and value.
  /// </summary>
  /// <param name="name">The header name.</param>
  /// <param name="value">The header value.</param>
  HttpHeader(String name, String value)
      : _name = name,
        _value = value {
    if (name.isEmpty) {
      throw ArgumentException("name shouldn't be null or empty", "name");
    }
  }

  /// <summary>
  /// Gets header name.
  /// </summary>
  final String _name;
  String get name => _name;

  /// <summary>
  /// Gets header value. If the header has multiple values they would be joined with a comma. To get separate values use <see cref="RequestHeaders.TryGetValues"/> or <see cref="ResponseHeaders.TryGetValues"/>.
  /// </summary>
  final String _value;
  String get value => _value;

  /// <inheritdoc/>
  @override
  int get hashCode {
    return _name.toLowerCase().hashCode + _value.toLowerCase().hashCode;
  }

  /// <inheritdoc/>
  @override
  bool operator ==(Object other) {
    if (other is! HttpHeader) return false;
    if (name != other.name) return false;
    if (value != other.value) return false;
    return true;
  }

  /// <inheritdoc/>
  @override
  String toString() => "${_name}:${_value}";
}

/// <summary>
/// Contains names of commonly used headers.
/// </summary>
class HttpHeaderNames {
  /// <summary>
  /// Returns. <code>"Date"</code>
  /// </summary>
  static String get date => "Date";

  /// <summary>
  /// Returns. <code>"x-ms-date"</code>
  /// </summary>
  static String get xMsDate => "x-ms-date";

  /// <summary>
  /// Returns. <code>"Content-Type"</code>
  /// </summary>
  static String get contentType => "Content-Type";

  /// <summary>
  /// Returns. <code>"Content-Length"</code>
  /// </summary>
  static String get contentLength => "Content-Length";

  /// <summary>
  /// Returns. <code>"ETag"</code>
  /// </summary>
  static String get eTag => "ETag";

  /// <summary>
  /// Returns. <code>"x-ms-request-id"</code>
  /// </summary>
  static String get xMsRequestId => "x-ms-request-id";

  /// <summary>
  /// Returns. <code>"User-Agent"</code>
  /// </summary>
  static String get userAgent => "User-Agent";

  /// <summary>
  /// Returns. <code>"Accept"</code>
  /// </summary>
  static String get accept => "Accept";

  /// <summary>
  /// Returns. <code>"Authorization"</code>
  /// </summary>
  static String get authorization => "Authorization";

  /// <summary>
  /// Returns. <code>"Range"</code>
  /// </summary>
  static String get range => "Range";

  /// <summary>
  /// Returns. <code>"x-ms-range"</code>
  /// </summary>
  static String get xMsRange => "x-ms-range";

  /// <summary>
  /// Returns. <code>"If-Match"</code>
  /// </summary>
  static String get ifMatch => "If-Match";

  /// <summary>
  /// Returns. <code>"If-None-Match"</code>
  /// </summary>
  static String get ifNoneMatch => "If-None-Match";

  /// <summary>
  /// Returns. <code>"If-Modified-Since"</code>
  /// </summary>
  static String get ifModifiedSince => "If-Modified-Since";

  /// <summary>
  /// Returns. <code>"If-Unmodified-Since"</code>
  /// </summary>
  static String get ifUnmodifiedSince => "If-Unmodified-Since";

  /// <summary>
  /// Returns. <code>"Prefer"</code>
  /// </summary>
  static String get prefer => "Prefer";

  /// <summary>
  /// Returns. <code>"Referer"</code>
  /// </summary>
  static String get referer => "Referer";

  /// <summary>
  /// Returns. <code>"Host"</code>
  /// </summary>
  static String get host => "Host";

  /// <summary>
  /// Returns <code>"Content-Disposition"</code>.
  /// </summary>
  static String get contentDisposition => "Content-Disposition";

  /// <summary>
  /// Returns <code>"WWW-Authenticate"</code>.
  /// </summary>
  static String get wwwAuthenticate => "WWW-Authenticate";
}

/// <summary>
/// Commonly defined header values.
/// </summary>
class HttpHeaderCommon {
  static const String applicationJson = "application/json";
  static const String applicationOctetStream = "application/octet-stream";
  static const String applicationFormUrlEncoded = "application/x-www-form-urlencoded";

  /// <summary>
  /// Returns header with name "ContentType" and value "application/json".
  /// </summary>
  static final HttpHeader jsonContentType =
      HttpHeader(HttpHeaderNames.contentType, applicationJson);

  /// <summary>
  /// Returns header with name "Accept" and value "application/json".
  /// </summary>
  static final HttpHeader jsonAccept = HttpHeader(HttpHeaderNames.accept, applicationJson);

  /// <summary>
  /// Returns header with name "ContentType" and value "application/octet-stream".
  /// </summary>
  static final HttpHeader octetStreamContentType =
      HttpHeader(HttpHeaderNames.contentType, applicationOctetStream);

  /// <summary>
  /// Returns header with name "ContentType" and value "application/x-www-form-urlencoded".
  /// </summary>
  static final HttpHeader formUrlEncodedContentType =
      HttpHeader(HttpHeaderNames.contentType, applicationFormUrlEncoded);
}

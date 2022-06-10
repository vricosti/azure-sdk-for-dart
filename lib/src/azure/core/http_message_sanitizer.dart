import 'dart:collection';

class HttpMessageSanitizer {
  final String logAllValue = "*";
  late bool _logAllHeaders;
  late bool _logFullQueries;
  late List<String> _allowedQueryParameters;
  late String _redactedPlaceholder;
  late HashSet<String> _allowedHeaders;

  static HttpMessageSanitizer createDefault() {
    return HttpMessageSanitizer([], []);
  }

  HttpMessageSanitizer(List<String> allowedQueryParameters, List<String> allowedHeaders,
      [String redactedPlaceholder = "REDACTED"]) {
    _logAllHeaders = allowedHeaders.contains(logAllValue);
    _logFullQueries = allowedQueryParameters.contains(logAllValue);

    _allowedQueryParameters = allowedQueryParameters;
    _redactedPlaceholder = redactedPlaceholder;
    _allowedHeaders = HashSet<String>.from(allowedHeaders);
  }

  String sanitizeHeader(String name, String value) {
    if (_logAllHeaders || _allowedHeaders.contains(name)) {
      return value;
    }

    return _redactedPlaceholder;
  }

  String sanitizeUrl(String url) {
    if (_logFullQueries) {
      return url;
    }
    return "";

// #if NET5_0_OR_GREATER
//             int indexOfQuerySeparator = url.IndexOf('?', StringComparison.Ordinal);
// #else
//             int indexOfQuerySeparator = url.IndexOf('?');
// #endif

//             if (indexOfQuerySeparator == -1)
//             {
//                 return url;
//             }

//             StringBuilder stringBuilder = new StringBuilder(url.Length);
//             stringBuilder.Append(url, 0, indexOfQuerySeparator);

//             string query = url.Substring(indexOfQuerySeparator);

//             int queryIndex = 1;
//             stringBuilder.Append('?');

//             do
//             {
//                 int endOfParameterValue = query.IndexOf('&', queryIndex);
//                 int endOfParameterName = query.IndexOf('=', queryIndex);
//                 bool noValue = false;

//                 // Check if we have parameter without value
//                 if ((endOfParameterValue == -1 && endOfParameterName == -1) ||
//                     (endOfParameterValue != -1 && (endOfParameterName == -1 || endOfParameterName > endOfParameterValue)))
//                 {
//                     endOfParameterName = endOfParameterValue;
//                     noValue = true;
//                 }

//                 if (endOfParameterName == -1)
//                 {
//                     endOfParameterName = query.Length;
//                 }

//                 if (endOfParameterValue == -1)
//                 {
//                     endOfParameterValue = query.Length;
//                 }
//                 else
//                 {
//                     // include the separator
//                     endOfParameterValue++;
//                 }

//                 ReadOnlySpan<char> parameterName = query.AsSpan(queryIndex, endOfParameterName - queryIndex);

//                 bool isAllowed = false;
//                 foreach (string name in _allowedQueryParameters)
//                 {
//                     if (parameterName.Equals(name.AsSpan(), StringComparison.OrdinalIgnoreCase))
//                     {
//                         isAllowed = true;
//                         break;
//                     }
//                 }

//                 int valueLength = endOfParameterValue - queryIndex;
//                 int nameLength = endOfParameterName - queryIndex;

//                 if (isAllowed)
//                 {
//                     stringBuilder.Append(query, queryIndex, valueLength);
//                 }
//                 else
//                 {
//                     if (noValue)
//                     {
//                         stringBuilder.Append(query, queryIndex, valueLength);
//                     }
//                     else
//                     {
//                         stringBuilder.Append(query, queryIndex, nameLength);
//                         stringBuilder.Append('=');
//                         stringBuilder.Append(_redactedPlaceholder);
//                         if (query[endOfParameterValue - 1] == '&')
//                         {
//                             stringBuilder.Append('&');
//                         }
//                     }
//                 }

//                 queryIndex += valueLength;
//             } while (queryIndex < query.Length);

//             return stringBuilder.ToString();
//         }
  }
}

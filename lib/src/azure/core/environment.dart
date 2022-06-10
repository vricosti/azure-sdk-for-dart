import 'dart:io' show Platform;

class Environment {
  static String? getEnvironmentVariable(String variable) {
    String? value;
    var env = Platform.environment;
    if (env.containsKey(variable)) {
      value = env[variable];
    }
    return value;
  }
}

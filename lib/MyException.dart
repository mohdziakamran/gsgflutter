class NoInternetException implements Exception {
  String message = "No Internet";
}

class UnknownException implements Exception {
  String message = "Unable to process, Try again Later";
}

class KnownException implements Exception {
  String message = "Unable to process, Try again Later";
}

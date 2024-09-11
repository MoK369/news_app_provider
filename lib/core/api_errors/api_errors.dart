import 'dart:io';

class ApiErrors {
  static String checkApiError(Object error) {
    if (error is SocketException) {
      return "No Internet connection 😑";
    } else if (error is HttpException) {
      return "Couldn't find the source 😱";
    } else if (error is FormatException) {
      return "Bad response format 👎";
    } else {
      return "Something went wrong!";
    }
  }
}

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:news/core/providers/locales/locales_provider.dart';

class ApiErrors {
  static String checkApiError(Object error, BuildContext context) {
    if (error is SocketException) {
      return LocalesProvider.getTrans(context).noInternet;
    } else if (error is HttpException) {
      return LocalesProvider.getTrans(context).couldNotFindArticle;
    } else if (error is FormatException) {
      return LocalesProvider.getTrans(context).badFormat;
    } else {
      return LocalesProvider.getTrans(context).somethingWentWrong;
    }
  }
}

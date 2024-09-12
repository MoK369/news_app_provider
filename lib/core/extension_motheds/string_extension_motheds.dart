import 'package:intl/intl.dart';

extension DateTimeFormat on String {
  String getLocalDateTimeFormat(String localeCode) {
    DateFormat inputDateFormat = DateFormat("yyyy-MM-ddTHH:mm:ssZ");
    DateTime date = inputDateFormat.parse(this);
    DateFormat outputFormat = DateFormat("yyy-MMM-dd hh:mm a", localeCode);
    return outputFormat.format(date);
  }
}

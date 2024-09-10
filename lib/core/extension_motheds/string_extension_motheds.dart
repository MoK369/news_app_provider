import 'package:intl/intl.dart';

extension DateTimeFormat on String {
  String getLocalDateTimeFormat() {
    DateFormat inputDateFormat = DateFormat("yyyy-MM-ddTHH:mm:ssZ");
    DateTime date = inputDateFormat.parse(this);
    DateFormat outputFormat = DateFormat("yyy-MMM-dd hh:mm a");
    return outputFormat.format(date);
  }
}

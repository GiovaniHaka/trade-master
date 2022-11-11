import 'package:intl/intl.dart';

class DateTimeFormat {
  final DateTime? dateTime;

  DateTimeFormat(this.dateTime);

  String toYMD() {
    final date = dateTime;

    if (date == null) {
      return '- / - / -';
    }

    return DateFormat.yMd().format(date);
  }
}

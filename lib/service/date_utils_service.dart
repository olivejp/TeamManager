import 'package:intl/intl.dart';

class DateUtilsService {
  static final DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm:ss');

  static DateTime convertDate(DateTime dateTime) {
    final String dateFormatted = dateTime.toIso8601String();
    final DateTime dateUtc = formatter.parseUtc(dateFormatted);
    return dateUtc.toLocal();
  }
}

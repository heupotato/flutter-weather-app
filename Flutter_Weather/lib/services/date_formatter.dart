import 'package:intl/intl.dart';

class DateFormatter {
  static String monthAndYear(DateTime dateTime) =>
      DateFormat('MMMM yyyy').format(dateTime);

  static String date(DateTime dateTime) =>
      DateFormat('EEEE dd MMMM').format(dateTime);

  static String dateTime(DateTime dateTime) =>
      DateFormat('EEEE dd MMMM yyyy - H:mm').format(dateTime);

  static String time(DateTime dateTime) => DateFormat('H:mm').format(dateTime);

  static String yearMonthDate(DateTime dateTime) =>
      DateFormat('yyyy-MM-dd').format(dateTime);

  static String weekDay(DateTime dateTime) =>
      DateFormat('EEEE').format(dateTime);

  static DateTime yearMonthDayHour(String initDate) =>
      DateFormat('yyyy MM dd hh').parse(initDate, true);
}

import 'package:intl/intl.dart';

class Apputils {
  static String formatDate(DateTime dateTime) {
    try {
      String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

      return formattedDate;
    } catch (e) {
      return "";
    }
  }

  static String formatDateString(int milliSecond) {
    try {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(milliSecond);
      String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);

      return formattedDate;
    } catch (e) {
      return "";
    }
  }
}

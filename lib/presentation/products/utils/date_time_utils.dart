import 'package:easy_localization/easy_localization.dart';

class DateTimeUtils {
  static String formatDate(String dateString, {String format = 'dd/MM/yyyy'}) {
    try {
      // Tarihi doğru formatta parse et
      DateTime dateTime = DateTime.parse(dateString);

      // İstenen formata dönüştür
      return DateFormat(format).format(dateTime);
    } catch (e) {
      return '-';
    }
  }

  static String _formatDateTime(DateTime dateTime, String format) {
    return format
        .replaceAll('yyyy', dateTime.year.toString())
        .replaceAll('MM', dateTime.month.toString().padLeft(2, '0'))
        .replaceAll('dd', dateTime.day.toString().padLeft(2, '0'))
        .replaceAll('HH', dateTime.hour.toString().padLeft(2, '0'))
        .replaceAll('mm', dateTime.minute.toString().padLeft(2, '0'))
        .replaceAll('ss', dateTime.second.toString().padLeft(2, '0'));
  }
}

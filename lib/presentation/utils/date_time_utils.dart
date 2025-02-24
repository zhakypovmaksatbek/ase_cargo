class DateTimeUtils {
  static String formatDate(String dateString, {String format = 'dd/MM/yyyy'}) {
    try {
      DateTime dateTime = DateTime.parse(dateString).toLocal();
      return _formatDateTime(dateTime, format);
    } catch (e) {
      return 'Unknown Date';
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

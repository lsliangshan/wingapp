import 'package:intl/intl.dart';

String dateFormat({
  required String timestamp,
  String format = 'yyyy-MM-dd HH:mm:ss',
}) {
  DateFormat formatter = DateFormat(format);

  String formattedDateTime = formatter
      .format(DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp)));
  return formattedDateTime;
}

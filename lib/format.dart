import "package:intl/intl.dart";
String formatDate( DateTime datetime) {
  var date = DateFormat("dd-MM-yyyy").format(datetime);
  return date;
}
String formatTime( DateTime datetime) {
  var formatTime = DateFormat.Hms().format(datetime);
  return formatTime;
}
String prettify(double d) => d.toStringAsFixed(2).replaceFirst(RegExp(r'\.?0*$'), '');

String formatDouble(double d) {
  return NumberFormat.decimalPattern().format(
    int.parse(prettify(d)),
  );
}
String formatPrice(double s) {
  return NumberFormat.currency(locale: "vi-VN").format(
    int.parse(prettify(s)),
  );
}
String totTitle(String input) {
  final List<String> splitStr = input.split(' ');
  for (int i = 0; i < splitStr.length; i++) {
    splitStr[i] =
    '${splitStr[i][0].toUpperCase()}${splitStr[i].substring(1)}';
  }
  final output = splitStr.join(' ');
  return output;
}
import 'package:intl/intl.dart';

Stream<String> getCurrentTime() {
  return Stream.periodic(Duration(seconds: 1), (_) {
    return DateFormat("hh:mm:ss").format(DateTime.now());
  });
}
import 'package:timeago/timeago.dart' as timeago;

class DateUtil {
  static String timeAgo(int timestamp) {
    return timeago
        .format(DateTime.fromMicrosecondsSinceEpoch(timestamp).toLocal());
  }
}

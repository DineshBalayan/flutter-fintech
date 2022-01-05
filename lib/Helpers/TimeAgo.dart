import 'package:bank_sathi/Helpers/extensions.dart';
import 'package:intl/intl.dart';

class TimeAgo {
  static String timeAgoSinceDate(String? dateString,
      {bool numericDates = true, bool notification = false}) {
    if (dateString == null || dateString.isEmpty) return "";
    DateTime? notificationDate;
    try {
      notificationDate = DateFormat('yyyy-MM-dd hh:mm:ss').parse(dateString);
    } catch (e) {
      try {
        notificationDate = DateFormat('yyyy-MM-dd\'T\'HH:mm:ssZ').parse(dateString);
      } catch (e) {
        notificationDate = DateTime.tryParse(dateString);
      }
    }

    if (notificationDate == null) return "";

    final date2 = DateTime.now();
    final difference = date2.difference(notificationDate);
    if (difference.inDays > 8) {
      return notificationDate.toUiDateTime() ?? dateString;
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }

  static String timeAgoSinceOnlyDate(String? dateString,
      {bool numericDates = true, bool notification = false}) {
    if (dateString == null || dateString.isEmpty) return "";
    DateTime? notificationDate;
    try {
      notificationDate = DateFormat('yyyy-MM-dd hh:mm:ss').parse(dateString);
    } catch (e) {
      try {
        notificationDate =
            DateFormat('yyyy-MM-dd').parse(dateString);
      } catch (e) {
        notificationDate = DateTime.tryParse(dateString);
      }
    }

    if (notificationDate == null) return "";

    final date2 = DateTime.now();
    final difference = date2.difference(notificationDate);
    if (difference.inDays > 8) {
      return notificationDate.toUiDate() ?? dateString;
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 minute ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }

  static bool isReturningDate(String? dateString,
      {bool numericDates = true, bool notification = false}) {
    DateTime? notificationDate;
    if (dateString == null || dateString.isEmpty) return false;
    try {
      notificationDate = DateFormat('yyyy-MM-dd hh:mm:ss').parse(dateString);
    } catch (e) {
      try {
        notificationDate =
            DateFormat('yyyy-MM-dd\'T\'HH:mm:ssZ').parse(dateString);
      } catch (e) {
        notificationDate = DateTime.tryParse(dateString);
      }
    }
    if (notificationDate == null) return false;

    final date2 = DateTime.now();
    final difference = date2.difference(notificationDate);
    return difference.inDays > 8;
  }
}

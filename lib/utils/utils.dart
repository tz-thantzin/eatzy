import 'package:intl/intl.dart';

class Utils {
  Utils._();
  static final Utils instance = Utils._();

  /// Converts a [DateTime] object to a formatted string in DD/MM/YYYY format.
  ///
  /// @param date The [DateTime] object to format.
  /// @return A [String] representing the date in DD/MM/YYYY format.
  String formatDateToDDMMYYYY(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }
}

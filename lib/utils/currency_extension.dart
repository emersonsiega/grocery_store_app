import 'package:intl/intl.dart';

extension CurrencyExtension on double {
  String get currency {
    NumberFormat formatter = NumberFormat.currency(
      decimalDigits: 2,
      locale: 'pt_BR',
      symbol: 'R\$',
    );

    return formatter.format(this);
  }
}

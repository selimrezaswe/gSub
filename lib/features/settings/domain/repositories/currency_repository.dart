import 'package:subscription_manager/features/settings/domain/entities/currency_item.dart';

/// Repository contract for loading available currencies.
abstract class CurrencyRepository {
  /// Returns a list of unique currencies, sorted by name.
  Future<List<CurrencyItem>> getCurrencies();
}

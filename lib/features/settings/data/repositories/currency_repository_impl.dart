import 'dart:convert';

import 'package:subscription_manager/features/settings/data/datasources/currency_asset_datasource.dart';
import 'package:subscription_manager/features/settings/data/models/currency_item_model.dart';
import 'package:subscription_manager/features/settings/domain/entities/currency_item.dart';
import 'package:subscription_manager/features/settings/domain/repositories/currency_repository.dart';

class CurrencyRepositoryImpl implements CurrencyRepository {
  CurrencyRepositoryImpl(this._dataSource);

  final CurrencyAssetDataSource _dataSource;

  @override
  Future<List<CurrencyItem>> getCurrencies() async {
    final data = await _dataSource.loadCurrenciesJson();
    final list = jsonDecode(data) as List<dynamic>;
    final seen = <String>{};
    final items = <CurrencyItem>[];
    for (final e in list) {
      final map = e as Map<String, dynamic>;
      CurrencyItemModel item = CurrencyItemModel.fromJson(map);
      if (item.code.isEmpty || seen.contains(item.code)) continue;
      if (item.code == 'EUR') {
        item = item.copyWith(emoji: '🇪🇺', name: 'Euro', symbol: '€', code: 'EUR');
      }
      seen.add(item.code);
      items.add(item);
    }
    items.sort((a, b) => a.code.compareTo(b.code));
    return items;
  }
}

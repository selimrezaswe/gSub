import 'package:flutter/services.dart';
import 'package:subscription_manager/core/constant/app_assets.dart';

/// Contract for loading raw currencies JSON.
abstract class CurrencyAssetDataSource {
  Future<String> loadCurrenciesJson();
}

/// Loads currencies from the bundled assets JSON.
class CurrencyAssetDataSourceImpl implements CurrencyAssetDataSource {
  CurrencyAssetDataSourceImpl(this._bundle);

  final AssetBundle _bundle;

  static  final String _assetPath = AppAssets.json.currencies;

  @override
  Future<String> loadCurrenciesJson() => _bundle.loadString(_assetPath);
}
